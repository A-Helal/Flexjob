
import 'package:flexiJobs/core/app_data/data/data_sources/job_category_data_sources.dart';

import 'package:flexiJobs/core/app_data/data/models/response/job_category_response_model.dart';

import 'package:flexiJobs/core/app_data/domain/repositories/job_category_repository.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
// ignore: unused_import
import 'package:flexiJobs/features/shared/entity/base_entity.dart';

@Injectable(as: JobCategoryRepository)
class JobCategoryRepositoryImp implements JobCategoryRepository {
  JobCategoryRepositoryImp({
    required this.jobCategoryRemoteDataSource,
  });
  final JobCategoryRemoteDataSource jobCategoryRemoteDataSource;

  Future<CustomResponseType<JobCategoryResponseModel>> getJobCategories(
      {required BaseRequestModel baseRequestModel}) async {
    return jobCategoryRemoteDataSource.getJobCategories(
        baseRequestModel: baseRequestModel);
  }
}



