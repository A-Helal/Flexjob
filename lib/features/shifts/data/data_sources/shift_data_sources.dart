import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/network/api/network_apis_constants.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/network/network_helper.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/jobs/data/models/response/job_list_category_response_model.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:injectable/injectable.dart';

abstract class ShiftRemoteDataSource {
  Future<CustomResponseType<BaseEntity<List<JobEntity>>>> getUpcomingJobs({required BaseRequestModel baseRequestModel});
  Future<CustomResponseType<BaseEntity<List<JobEntity>>>> getPastJobs({required BaseRequestModel baseRequestModel});
  Future<CustomResponseType<BaseEntity<List<JobEntity>>>> getAppliedJobs({required BaseRequestModel baseRequestModel});
}

@Injectable(as: ShiftRemoteDataSource)
class ShiftRemoteDataSourceImpl implements ShiftRemoteDataSource {
  ShiftRemoteDataSourceImpl(this.networkHelper);
  final NetworkHelper networkHelper;

  @override
  Future<CustomResponseType<BaseEntity<List<JobEntity>>>> getUpcomingJobs(
      {required BaseRequestModel baseRequestModel}) async {
    ({dynamic response, bool success}) result =
        await networkHelper.get(path: ApiConstants.getUpcomingJob, queryParams: baseRequestModel.toJson());

    if (result.success) {
      return right(_parseJobsResponse(result.response));
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }

  @override
  Future<CustomResponseType<BaseEntity<List<JobEntity>>>> getPastJobs(
      {required BaseRequestModel baseRequestModel}) async {
    ({dynamic response, bool success}) result =
        await networkHelper.get(path: ApiConstants.getPastJobs, queryParams: baseRequestModel.toJson());

    if (result.success) {
      return right(_parseJobsResponse(result.response));
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }

  @override
  Future<CustomResponseType<BaseEntity<List<JobEntity>>>> getAppliedJobs(
      {required BaseRequestModel baseRequestModel}) async {
    ({dynamic response, bool success}) result =
        await networkHelper.get(path: ApiConstants.getAppliedJobs, queryParams: baseRequestModel.toJson());

    if (result.success) {
      return right(_parseJobsResponse(result.response));
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }

  JobListCategoryResponseModel _parseJobsResponse(dynamic response) {
    final dynamic jobsRaw = response['data']?['jobs'];
    if (jobsRaw is Map<String, dynamic>) {
      return JobListCategoryResponseModel.fromJson(jobsRaw);
    }
    return JobListCategoryResponseModel(data: const <JobEntity>[], totalRecords: 0);
  }
}
