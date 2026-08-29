import 'package:flexiJobs/features/jobs/data/models/request/jobs_request_model.dart';
import 'package:flexiJobs/features/jobs/data/models/response/job_list_category_response_model.dart';
import 'package:flexiJobs/features/jobs/data/models/response/jobs_list_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/network/api/network_apis_constants.dart';
import 'package:flexiJobs/core/network/network_helper.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/error/failure.dart';

abstract class JobListForCategortRemoteDataSource {
  Future<CustomResponseType<JobListCategoryResponseModel>> getAvailableJobs(
      {required JobsRequestModel jobRequestModel});
}

@Injectable(as: JobListForCategortRemoteDataSource)
class JobRemoteDataSourceImpl implements JobListForCategortRemoteDataSource {
  JobRemoteDataSourceImpl(this.networkHelper);
  final NetworkHelper networkHelper;

  @override
  Future<CustomResponseType<JobListCategoryResponseModel>> getAvailableJobs(
      {required JobsRequestModel jobRequestModel}) async {
    ({dynamic response, bool success}) result =
        await networkHelper.get(path: ApiConstants.getAvailableJobsForCategory, queryParams: jobRequestModel.toJson());

    if (result.success) {
      // totalRecords is parsed inside fromJson via the 'total' field.
      final JobListCategoryResponseModel model =
          JobListCategoryResponseModel.fromJson(result.response['data']['jobs']);
      return right(model);
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }
}
