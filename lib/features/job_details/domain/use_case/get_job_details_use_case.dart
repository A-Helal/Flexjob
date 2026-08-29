 import 'package:flexiJobs/features/job_details/domain/repository/job_details_repository.dart';
import 'package:flexiJobs/features/jobs/domain/entities/app_job_entity.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/domain/usecase/base_usecase.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flexiJobs/core/network/base_handling.dart';


@injectable
class GetJobDetailsUseCase implements UseCase< AppJobEntity, BaseRequestModel> {
  GetJobDetailsUseCase({required this.jobDetailsRepository});
  final JobDetailsRepository jobDetailsRepository;

  @override
  Future<CustomResponseType< AppJobEntity>> call(
     BaseRequestModel  baseRequestModel,
  ) async {
    return jobDetailsRepository.getJobDetails(
     baseRequestModel:baseRequestModel,
    );
  }
}
