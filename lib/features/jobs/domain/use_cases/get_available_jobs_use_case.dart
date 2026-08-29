import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_filter_params.dart';
import 'package:flexiJobs/features/jobs/domain/entities/jobs_list_entity.dart';
import 'package:flexiJobs/features/jobs/domain/repositories/job_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAvailableJobsUseCase {
  const GetAvailableJobsUseCase({required this.jobRepository});

  final JobRepository jobRepository;

  Future<Either<Failure, List<JobsListEntity>>> call(JobFilterParams params) =>
      jobRepository.getAvailableJobs(params);
}
