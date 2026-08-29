
import 'package:flexiJobs/core/app_data/data/models/response/job_category_response_model.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/network/api/network_apis_constants.dart';
import 'package:flexiJobs/core/network/network_helper.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/error/failure.dart';

abstract class JobCategoryRemoteDataSource {
  Future<CustomResponseType<JobCategoryResponseModel>> getJobCategories(
      {required BaseRequestModel baseRequestModel});
}

@Injectable(as: JobCategoryRemoteDataSource)
class GovernorateRemoteDataSourceImpl implements JobCategoryRemoteDataSource {
  GovernorateRemoteDataSourceImpl(this.networkHelper);
  final NetworkHelper networkHelper;

  @override
  Future<CustomResponseType<JobCategoryResponseModel>> getJobCategories(
      {required BaseRequestModel baseRequestModel}) async {
    ({dynamic response, bool success}) result = await networkHelper.post(
        path: ApiConstants.getJobCategories, data: baseRequestModel.toJson());

    if (result.success) {
      return right(JobCategoryResponseModel.fromJson(
          result.response['data']['job_categories']));
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }
}

