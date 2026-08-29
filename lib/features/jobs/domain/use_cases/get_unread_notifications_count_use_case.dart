import 'package:flexiJobs/features/jobs/domain/repositories/job_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUnreadNotificationsCountUseCase {
  GetUnreadNotificationsCountUseCase({required this.jobRepository});

  final JobRepository jobRepository;

  Future<int> call() => jobRepository.getUnreadNotificationsCount();
}
