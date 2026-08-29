import 'package:bloc/bloc.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/core/app_data/domain/entities/app_user_entity.dart';
import 'package:flexiJobs/features/job_details/constants/job_details_constants.dart';
import 'package:flexiJobs/features/job_details/domain/use_case/get_job_details_use_case.dart';
import 'package:flexiJobs/features/job_details/presentation/enum/job_state_type.dart';
import 'package:flexiJobs/features/jobs/domain/entities/app_job_entity.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:injectable/injectable.dart';

import 'package:flexiJobs/features/job_details/domain/use_case/apply_on_job_use_case.dart';
import 'package:flexiJobs/features/job_details/domain/use_case/cancel_job_use_case.dart';
import 'package:flexiJobs/features/job_details/domain/use_case/check_in_use_case.dart';
import 'package:flexiJobs/features/job_details/domain/use_case/check_out_use_case.dart';

part 'job_details_state.dart';

@injectable
class JobDetailsCubit extends Cubit<JobDetailsState> {
  JobDetailsCubit({
    required this.checkInUseCase,
    required this.checkoutUseCase,
    required this.applyOnJobUseCase,
    required this.cancelJobUseCase,
    required this.getJobDetailsUseCase,
  }) : super(JobDetailsInitialState());

  final CheckInUseCase checkInUseCase;
  final CheckoutUseCase checkoutUseCase;
  final ApplyOnJobUseCase applyOnJobUseCase;
  final CancelJobUseCase cancelJobUseCase;
  final GetJobDetailsUseCase getJobDetailsUseCase;

  Future<void> getJobById({required int id, bool keepView = false, JobStateType? jobStateType}) async {
    JobDetailsReadyState currentState;
    if (keepView) {
      currentState = state as JobDetailsReadyState;
      emit(JobDetailsReadyState(appJobEntity: currentState.appJobEntity, inProgress: true));
    } else {
      emit(JobDetailsLoadingState());
    }
    final CustomResponseType<AppJobEntity> eitherPackagesOrFailure =
        await getJobDetailsUseCase(BaseRequestModel(id: id));

    eitherPackagesOrFailure.fold((Failure failure) {
      emit(JobDetailsErrorState(message: FailureToMessage().map(failure)));
    }, (AppJobEntity response) {
      emit(JobDetailsReadyState(appJobEntity: response, jobStateType: jobStateType));
    });
  }

  Future<void> applyOnJob({required int id}) async {
    JobDetailsReadyState currenState = state as JobDetailsReadyState;

    emit(JobDetailsReadyState(appJobEntity: currenState.appJobEntity, inProgress: true));
    final CustomResponseType<String> eitherPackagesOrFailure = await applyOnJobUseCase(id);

    eitherPackagesOrFailure.fold((Failure failure) {
      emit(JobDetailsReadyState(
          appJobEntity: currenState.appJobEntity, message: FailureToMessage().map(failure)));
    }, (String response) {
      if (response == "intro") {
       emit(JobDetailsReadyState(appJobEntity: currenState.appJobEntity,isNeedVideo: true ));

      } else {
        getJobById(id: id, jobStateType: JobStateType.applied, keepView: true);
      }
    });
  }

  Future<void> cancelJob({required int id}) async {
    JobDetailsReadyState currenState = state as JobDetailsReadyState;

    emit(JobDetailsReadyState(appJobEntity: currenState.appJobEntity, inProgress: true));
    final CustomResponseType<String> eitherPackagesOrFailure = await cancelJobUseCase(id);

    eitherPackagesOrFailure.fold((Failure failure) {
      emit(JobDetailsReadyState(
          appJobEntity: currenState.appJobEntity, message: FailureToMessage().map(failure)));
    }, (String response) {
      getJobById(id: id, jobStateType: JobStateType.canceld, keepView: true);
    });
  }

  Future<void> checkIn({required int id}) async {
    JobDetailsReadyState currenState = state as JobDetailsReadyState;

    emit(JobDetailsReadyState(appJobEntity: currenState.appJobEntity, inProgress: true));
    final CustomResponseType<String> eitherPackagesOrFailure = await checkInUseCase(id);

    eitherPackagesOrFailure.fold((Failure failure) {
      emit(JobDetailsReadyState(
          appJobEntity: currenState.appJobEntity, message: FailureToMessage().map(failure)));
    }, (String response) {
      getJobById(id: id, jobStateType: JobStateType.checkedIn, keepView: true);
    });
  }

  Future<void> checkout({required int id}) async {
    JobDetailsReadyState currenState = state as JobDetailsReadyState;

    emit(JobDetailsReadyState(appJobEntity: currenState.appJobEntity, inProgress: true));
    final CustomResponseType<String> eitherPackagesOrFailure = await checkoutUseCase(id);

    eitherPackagesOrFailure.fold((Failure failure) {
      emit(JobDetailsReadyState(
          appJobEntity: currenState.appJobEntity, message: FailureToMessage().map(failure)));
    }, (String response) {
      getJobById(id: id, jobStateType: JobStateType.checkedout, keepView: true);
    });
  }
}
