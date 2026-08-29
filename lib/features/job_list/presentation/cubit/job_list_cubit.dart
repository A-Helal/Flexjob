import 'package:bloc/bloc.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/job_list/domain/use_cases/get_jobs_list_for_category.dart';
import 'package:flexiJobs/features/jobs/data/models/request/jobs_request_model.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:injectable/injectable.dart';

part 'job_list_state.dart';

@injectable
class JobListCubit extends Cubit<JobListState> {
  JobListCubit({required this.getAvailableJobsForCategoryUseCase}) : super(JobListInitialState());
  final GetAvailableJobsForCategoryUseCase getAvailableJobsForCategoryUseCase;

  Future<void> getAvailableJobs({
    JobsRequestModel? jobRequestModel,
    int? categoryId,
  }) async {
    emit(JobListLoadingState());

    final CustomResponseType<BaseEntity<List<JobEntity>>> eitherPackagesOrFailure =
        await getAvailableJobsForCategoryUseCase(JobsRequestModel(page: 1, pageSize: 5, jobCategoryId: categoryId));

    eitherPackagesOrFailure.fold((Failure failure) {
      emit(JobListErrorState(message: FailureToMessage().map(failure)));
    }, (BaseEntity<List<JobEntity>> response) {
      emit(JobListReadyState(
        jobList: response.data!,
        pageNumber: 1,
        total: response.totalRecords,
        catgoryId: categoryId,
      ));
    });
  }

  Future<void> loadMoreJobs() async {
    if (state is! JobListReadyState) return;
    final JobListReadyState currentState = state as JobListReadyState;
    final int nextPage = (currentState.pageNumber ?? 1) + 1;

    emit(JobListReadyState(
      inProgress: true,
      jobList: currentState.jobList,
      catgoryId: currentState.catgoryId,
      total: currentState.total,
      pageNumber: currentState.pageNumber,
    ));

    final CustomResponseType<BaseEntity<List<JobEntity>>> eitherPackagesOrFailure =
        await getAvailableJobsForCategoryUseCase(JobsRequestModel(
      page: nextPage,
      pageSize: 5,
      jobCategoryId: currentState.catgoryId,
    ));

    eitherPackagesOrFailure.fold((Failure failure) {
      emit(JobListErrorState(message: FailureToMessage().map(failure)));
    }, (BaseEntity<List<JobEntity>> response) {
      emit(JobListReadyState(
        jobList: (currentState.jobList ?? <JobEntity>[]) + (response.data ?? <JobEntity>[]),
        total: currentState.total,
        catgoryId: currentState.catgoryId,
        pageNumber: nextPage,
      ));
    });
  }
}
