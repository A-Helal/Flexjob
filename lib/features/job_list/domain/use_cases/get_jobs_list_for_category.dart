 import 'package:flexiJobs/features/job_list/domain/repositories/job_list_repository.dart';
import 'package:flexiJobs/features/jobs/data/models/request/jobs_request_model.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/features/jobs/domain/entities/jobs_list_entity.dart';
import 'package:flexiJobs/features/jobs/domain/repositories/job_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/domain/usecase/base_usecase.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flexiJobs/core/network/base_handling.dart';


@injectable
class GetAvailableJobsForCategoryUseCase implements UseCase<BaseEntity<List<JobEntity>>, JobsRequestModel> {
  GetAvailableJobsForCategoryUseCase({required this.jobListRepository});
  final JobListRepository jobListRepository;

  @override
  Future<CustomResponseType<BaseEntity<List<JobEntity>>>> call(
     JobsRequestModel  jobRequestModel,
  ) async {
    return jobListRepository.getAvailableJobsForCategory(
     jobRequestModel:jobRequestModel,
    );
  }
}
