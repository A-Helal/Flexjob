
import 'package:flexiJobs/core/app_data/domain/entities/job_category_entity.dart';

import 'package:flexiJobs/core/app_data/domain/repositories/job_category_repository.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/domain/usecase/base_usecase.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flexiJobs/core/network/base_handling.dart';

@injectable
class GetJobCategoriesUseCase implements UseCase<BaseEntity<List<JobCategoryEntity>>, BaseRequestModel> {
  GetJobCategoriesUseCase({required this.jobCategoryRepository});
  final JobCategoryRepository jobCategoryRepository;

  @override
  Future<CustomResponseType<BaseEntity<List<JobCategoryEntity>>>> call(
    BaseRequestModel baseRequestModel,
  ) async {
    return jobCategoryRepository.getJobCategories(
      baseRequestModel: baseRequestModel,
    );
  }
}


