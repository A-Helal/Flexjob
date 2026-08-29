import 'package:flexiJobs/features/jobs/domain/entities/upcoming_shift_entity.dart';
import 'package:flexiJobs/features/jobs/domain/repositories/job_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/domain/usecase/base_usecase.dart';
import 'package:flexiJobs/core/network/base_handling.dart';

@injectable
class GetUpComingShiftUseCase implements UseCaseNoParam<UpcomingShiftEntity?> {
  GetUpComingShiftUseCase({required this.jobRepository});

  final JobRepository jobRepository;

  @override
  Future<CustomResponseType<UpcomingShiftEntity?>> call() async {
    return jobRepository.getUpcomingShift();
  }
}
