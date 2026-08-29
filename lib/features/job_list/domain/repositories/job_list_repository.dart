import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/features/jobs/data/models/request/jobs_request_model.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';

abstract class JobListRepository {

 Future<CustomResponseType<BaseEntity<List<JobEntity>>>> getAvailableJobsForCategory({ 
 required JobsRequestModel jobRequestModel });

  
}