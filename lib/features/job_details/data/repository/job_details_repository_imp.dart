import 'package:flexiJobs/features/job_details/data/data_sources/job_details_data_sources.dart';
import 'package:flexiJobs/features/job_details/domain/repository/job_details_repository.dart';
import 'package:flexiJobs/features/jobs/domain/entities/app_job_entity.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/network/base_handling.dart';

@Injectable(as: JobDetailsRepository)
class JobDetailsRepositoryImp implements JobDetailsRepository {
  JobDetailsRepositoryImp({
    required this.jobDetailsDataSources,
  });
  final JobDetailsDataSources jobDetailsDataSources;

  Future<CustomResponseType<AppJobEntity>> getJobDetails({required BaseRequestModel baseRequestModel}) async {
    return jobDetailsDataSources.getJobDetails(baseRequestModel: baseRequestModel);
  }

  Future<CustomResponseType<String>> checkIn({required int jobId}) async {
    return jobDetailsDataSources.checkIn(jobId: jobId);
  }

  Future<CustomResponseType<String>> checkout({required int jobId}) async {
    return jobDetailsDataSources.checkout(jobId: jobId);
  }

  Future<CustomResponseType<String>> applyOnJob({required int jobId}) async {
    return jobDetailsDataSources.applyOnJob(jobId: jobId);
  }

  Future<CustomResponseType<String>> cancelJob({required int jobId}) async {
    return jobDetailsDataSources.cancelJob(jobId: jobId);
  }
}
