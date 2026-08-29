// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/jobs/domain/entities/upcoming_shift_entity.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/features/jobs/domain/use_cases/get_upcoming_shift_use_case.dart';
import 'package:flexiJobs/features/jobs/presentation/jobs_helper.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';

import 'package:flexiJobs/features/shifts/domain/use_cases/get_applied_jobs_use_case.dart';
import 'package:flexiJobs/features/shifts/domain/use_cases/get_past_jobs_use_case.dart';
import 'package:flexiJobs/features/shifts/domain/use_cases/get_upcoming_jobs_use_case.dart';
import 'package:flexiJobs/features/shifts/presentation/screens/shifts_screen.dart';
import 'package:injectable/injectable.dart';

part 'shift_state.dart';

@injectable
class ShiftsCubit extends Cubit<ShiftState> {
  ShiftsCubit({
    required this.getUpcomingJobsUseCase,
    required this.getPastJobsUseCase,
    required this.getAppliedJobsUseCase,
    required this.getUpComingShiftUseCase,
  }) : super(ShiftInitialState());

  final GetUpcomingJobsUseCase getUpcomingJobsUseCase;
  final GetPastJobsUseCase getPastJobsUseCase;
  final GetAppliedJobsUseCase getAppliedJobsUseCase;
  final GetUpComingShiftUseCase getUpComingShiftUseCase;

  Future<void> getAppliedJobs({BaseRequestModel? baseRequestModel}) async {
    final CustomResponseType<BaseEntity<List<JobEntity>>> eitherPackagesOrFailure =
        await getAppliedJobsUseCase(baseRequestModel ?? BaseRequestModel(page: 1, pageSize: 5));

    eitherPackagesOrFailure.fold((Failure failure) {
      emit(ShiftErrorState(message: FailureToMessage().map(failure)));
    }, (BaseEntity<List<JobEntity>> response) {
      emit(ShiftReadyState(jobs: response.data ?? <JobEntity>[], total: response.totalRecords ?? 0));
    });
  }

  Future<void> getPastJobs({BaseRequestModel? baseRequestModel}) async {
    final CustomResponseType<BaseEntity<List<JobEntity>>> eitherPackagesOrFailure =
        await getPastJobsUseCase(baseRequestModel ?? BaseRequestModel(page: 1, pageSize: 5));

    eitherPackagesOrFailure.fold((Failure failure) {
      emit(ShiftErrorState(message: FailureToMessage().map(failure)));
    }, (BaseEntity<List<JobEntity>> response) {
      emit(ShiftReadyState(jobs: response.data ?? <JobEntity>[], total: response.totalRecords ?? 0));
    });
  }

  Future<void> getUpcomingJobs({BaseRequestModel? baseRequestModel}) async {
    final CustomResponseType<BaseEntity<List<JobEntity>>> eitherPackagesOrFailure =
        await getUpcomingJobsUseCase(baseRequestModel ?? BaseRequestModel(page: 1, pageSize: 5));

    eitherPackagesOrFailure.fold((Failure failure) {
      emit(ShiftErrorState(message: FailureToMessage().map(failure)));
    }, (BaseEntity<List<JobEntity>> response) async {
      UpcomingShiftEntity? upcomingShift;
      if (LocalData.user?.status == "approved") {
       upcomingShift = await getUpcomingShift();
      }

      emit(ShiftReadyState(
        jobs: response.data ?? <JobEntity>[],
        total: response.totalRecords ?? 0,
        jobComingShiftEntity: upcomingShift,
      ));
    });
  }

  Future<void> loadMoreJobs(
      {BaseRequestModel? baseRequestModel, required JobDate jobDate, required int pageNumber}) async {
    final ShiftState currentState = state;
    if (currentState is! ShiftReadyState) return;

    CustomResponseType<BaseEntity<List<JobEntity>>> eitherPackagesOrFailure;
    final ShiftReadyState shiftReadyState = currentState;
    if (shiftReadyState.inProgress || shiftReadyState.jobs.length >= shiftReadyState.total) return;

    emit(shiftReadyState.copyWith(inProgress: true));
    final BaseRequestModel request = baseRequestModel ?? BaseRequestModel(page: pageNumber, pageSize: 5);
    if (jobDate == JobDate.applied) {
      eitherPackagesOrFailure = await getAppliedJobsUseCase(request);
    } else if (jobDate == JobDate.upcoming) {
      eitherPackagesOrFailure = await getUpcomingJobsUseCase(request);
    } else {
      eitherPackagesOrFailure = await getPastJobsUseCase(request);
    }
    eitherPackagesOrFailure.fold((Failure failure) {
      emit(shiftReadyState.copyWith(inProgress: false));
      emit(ShiftErrorState(message: FailureToMessage().map(failure)));
    }, (BaseEntity<List<JobEntity>> response) async {
      UpcomingShiftEntity? upcomingShift;
      if (jobDate == JobDate.upcoming) {
        upcomingShift = await getUpcomingShift();
      }
      emit(ShiftReadyState(
          jobs: shiftReadyState.jobs + (response.data ?? <JobEntity>[]),
          total: shiftReadyState.total,
          pageNumber: pageNumber,
          jobComingShiftEntity: upcomingShift ?? shiftReadyState.jobComingShiftEntity));
    });
  }

  void profileUnderReview() => emit(ProfileUnderReviewState());

  void getDummy() {
    assert(() {
      emit(ShiftReadyState(total: 40, jobs: JobsHelper.generateDummyJobs(20)));
      return true;
    }());
  }

  Future<UpcomingShiftEntity?> getUpcomingShift() async {
    UpcomingShiftEntity? entity;
    final CustomResponseType<UpcomingShiftEntity?> eitherPackagesOrFailure = await getUpComingShiftUseCase();

    eitherPackagesOrFailure.fold((Failure failure) {
      entity = null;
    }, (UpcomingShiftEntity? response) {
      entity = response;
    });

    return entity;
  }
}
