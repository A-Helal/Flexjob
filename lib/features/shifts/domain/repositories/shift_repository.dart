import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';

abstract class ShiftRepository {
  Future<CustomResponseType<BaseEntity<List<JobEntity>>>> getUpcomingJobs({
    required BaseRequestModel baseRequestModel,
  });
  Future<CustomResponseType<BaseEntity<List<JobEntity>>>> getPastJobs({
    required BaseRequestModel baseRequestModel,
  });
  Future<CustomResponseType<BaseEntity<List<JobEntity>>>> getAppliedJobs({
    required BaseRequestModel baseRequestModel,
  });
}
