import 'package:flexiJobs/features/jobs/data/models/response/app_job_dto.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/network/api/network_apis_constants.dart';
import 'package:flexiJobs/core/network/network_helper.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/jobs/domain/entities/app_job_entity.dart';

abstract class JobDetailsDataSources {
  Future<CustomResponseType<AppJobEntity>> getJobDetails({required BaseRequestModel baseRequestModel});
  Future<CustomResponseType<String>> checkIn({required int jobId});
  Future<CustomResponseType<String>> checkout({required int jobId});
  Future<CustomResponseType<String>> cancelJob({required int jobId});
  Future<CustomResponseType<String>> applyOnJob({required int jobId});
}

@Injectable(as: JobDetailsDataSources)
class JobDetailsDataSourcesImpl implements JobDetailsDataSources {
  JobDetailsDataSourcesImpl(this.networkHelper);
  final NetworkHelper networkHelper;

  @override
  Future<CustomResponseType<AppJobEntity>> getJobDetails({required BaseRequestModel baseRequestModel}) async {
    ({dynamic response, bool success}) result =
        await networkHelper.get(path: ApiConstants.getJobById, queryParams: baseRequestModel.toJson());

    if (result.success) {
      return right(AppJobDto.fromJson(result.response['data'] as Map<String, dynamic>).toEntity());
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }

  @override
  Future<CustomResponseType<String>> checkIn({required int jobId}) async {
    ({dynamic response, bool success}) result =
        await networkHelper.post(path: ApiConstants.checkIn, data: <String, dynamic>{"job_id": jobId});

    if (result.success) {
      return right("Success");
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }

  @override
  Future<CustomResponseType<String>> checkout({required int jobId}) async {
    ({dynamic response, bool success}) result =
        await networkHelper.post(path: ApiConstants.checkOut, data: <String, dynamic>{"job_id": jobId});

    if (result.success) {
      return right("Success");
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }

  @override
  Future<CustomResponseType<String>> applyOnJob({required int jobId}) async {
    ({dynamic response, bool success}) result =
        await networkHelper.post(path: ApiConstants.applyOnJob, data: <String, dynamic>{"id": jobId});

    if (result.success) {
      if(result.response=="intro"){
          return right("intro");
      }
      return right("Success");
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }

  @override
  Future<CustomResponseType<String>> cancelJob({required int jobId}) async {
    ({dynamic response, bool success}) result =
        await networkHelper.post(path: ApiConstants.cancelJob, data: <String, dynamic>{"id": jobId});

    if (result.success) {
      return right("Success");
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }
}
