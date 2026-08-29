// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/core/app_data/domain/entities/job_category_entity.dart';
import 'package:flexiJobs/core/app_data/domain/use_cases/get_job_categories.dart';

import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:injectable/injectable.dart';

part 'job_category_state.dart';

@injectable
class JobCategoryCubit extends Cubit<JobCategoryState> {
  JobCategoryCubit({required this.getJobCategoriesUseCase})
      : super(JobCategoryInitialState());
  final GetJobCategoriesUseCase getJobCategoriesUseCase;

  Future<void> getJobCategory({BaseRequestModel? baseRequestModel}) async {
    final CustomResponseType<BaseEntity<List<JobCategoryEntity>>>
        eitherPackagesOrFailure =
        await getJobCategoriesUseCase(BaseRequestModel(
      page: 1,
      pageSize: 100,
    ));

    eitherPackagesOrFailure.fold((Failure failure) {},
        (BaseEntity<List<JobCategoryEntity>> response) async {
      await LocalData.setJobCateGories(response.data!);
    });
  }
}
