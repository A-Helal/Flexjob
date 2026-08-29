import 'package:flexiJobs/features/job_list/data/data_sources/job_list_for_category_data_sources.dart';
import 'package:flexiJobs/features/job_list/domain/repositories/job_list_repository.dart';
import 'package:flexiJobs/features/jobs/data/data_sources/job_data_source.dart';
import 'package:flexiJobs/features/jobs/data/models/request/jobs_request_model.dart';
import 'package:flexiJobs/features/jobs/data/models/response/job_list_category_response_model.dart';
import 'package:flexiJobs/features/jobs/data/models/response/jobs_list_dto.dart';
import 'package:flexiJobs/features/jobs/domain/repositories/job_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/network/base_handling.dart';

@Injectable(as: JobListRepository)
class JobListRepositoryImp implements JobListRepository {
  JobListRepositoryImp({
    required this.jobListForCategortRemoteDataSource,
  });
  final JobListForCategortRemoteDataSource jobListForCategortRemoteDataSource;

  Future<CustomResponseType<JobListCategoryResponseModel>> getAvailableJobsForCategory(
      {required JobsRequestModel jobRequestModel}) async {
    return jobListForCategortRemoteDataSource.getAvailableJobs(
        jobRequestModel: jobRequestModel);
  }
}
