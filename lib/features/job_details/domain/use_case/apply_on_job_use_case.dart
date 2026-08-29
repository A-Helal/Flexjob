import 'package:flexiJobs/features/job_details/domain/repository/job_details_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/domain/usecase/base_usecase.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flexiJobs/core/network/base_handling.dart';

@injectable
class ApplyOnJobUseCase implements UseCase<String, int> {
  ApplyOnJobUseCase({required this.jobDetailsRepository});
  final JobDetailsRepository jobDetailsRepository;

  @override
  Future<CustomResponseType<String>> call(
    int jobId,
  ) async {
    return jobDetailsRepository.applyOnJob(
      jobId: jobId,
    );
  }
}
