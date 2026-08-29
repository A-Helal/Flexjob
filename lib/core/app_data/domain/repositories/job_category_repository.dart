import 'package:flexiJobs/core/network/base_handling.dart';

import 'package:flexiJobs/core/app_data/domain/entities/job_category_entity.dart';

import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';

abstract class JobCategoryRepository {

Future<CustomResponseType<BaseEntity<List<JobCategoryEntity>>>> getJobCategories({ 
 required BaseRequestModel baseRequestModel });
  
}

