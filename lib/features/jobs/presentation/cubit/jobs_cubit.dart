import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/jobs/domain/entities/home_data_entity.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_filter_params.dart';
import 'package:flexiJobs/features/jobs/domain/entities/jobs_list_entity.dart';
import 'package:flexiJobs/features/jobs/domain/use_cases/get_available_jobs_use_case.dart';
import 'package:flexiJobs/features/jobs/domain/use_cases/get_home_data_use_case.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:injectable/injectable.dart';

part 'jobs_state.dart';

@injectable
class JobsCubit extends Cubit<JobsState> {
  JobsCubit({
    required this.getHomeDataUseCase,
    required this.getAvailableJobsUseCase,
  }) : super(const JobsInitial());

  final GetHomeDataUseCase getHomeDataUseCase;
  final GetAvailableJobsUseCase getAvailableJobsUseCase;

  Future<void> loadHome() async {
    emit(const JobsLoading());
    final Either<Failure, HomeDataEntity> result = await getHomeDataUseCase(
      const JobFilterParams(),
      userStatus: LocalData.user?.status,
    );

    result.fold(
      (Failure failure) =>
          emit(JobsError(message: FailureToMessage().map(failure))),
      (HomeDataEntity data) => emit(JobsLoaded(data: data)),
    );
  }

  Future<void> filterByGovernorate(int? governorateId) async {
    final JobsState current = state;
    if (current is! JobsLoaded) return;

    final JobFilterParams params =
        current.activeFilter?.copyWith(governorateId: governorateId) ??
            JobFilterParams(governorateId: governorateId);

    emit(current.copyWith(isFiltering: true, activeFilter: params));

    final CustomResponseType<List<JobsListEntity>> result =
        await getAvailableJobsUseCase(params);

    result.fold(
      (Failure failure) => emit(current.copyWith(
        isFiltering: false,
        filterError: FailureToMessage().map(failure),
      )),
      (List<JobsListEntity> jobs) => emit(
        current.copyWith(
          data: current.data.copyWith(jobCategories: jobs),
          isFiltering: false,
          activeFilter: params,
        ),
      ),
    );
  }

  void clearNotificationBadge() {
    final JobsState current = state;
    if (current is! JobsLoaded) return;
    emit(current.copyWith(
      data: HomeDataEntity(
        jobCategories: current.data.jobCategories,
        unreadNotificationCount: 0,
        upcomingShift: current.data.upcomingShift,
      ),
    ));
  }

  Future<void> refresh() => loadHome();
}
