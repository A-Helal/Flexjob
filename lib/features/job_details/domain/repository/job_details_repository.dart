import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/features/jobs/domain/entities/app_job_entity.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';

abstract class JobDetailsRepository {
  Future<CustomResponseType<AppJobEntity>> getJobDetails({required BaseRequestModel baseRequestModel});

  Future<CustomResponseType<String>> checkIn({required int jobId});
  Future<CustomResponseType<String>> checkout({required int jobId});
  Future<CustomResponseType<String>> applyOnJob({required int jobId});
  Future<CustomResponseType<String>> cancelJob({required int jobId});
}
