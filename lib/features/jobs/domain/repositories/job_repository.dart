import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_filter_params.dart';
import 'package:flexiJobs/features/jobs/domain/entities/jobs_list_entity.dart';
import 'package:flexiJobs/features/jobs/domain/entities/upcoming_shift_entity.dart';

abstract class JobRepository {
  Future<Either<Failure, List<JobsListEntity>>> getAvailableJobs(
    JobFilterParams params,
  );

  Future<Either<Failure, UpcomingShiftEntity?>> getUpcomingShift();

  Future<int> getUnreadNotificationsCount();
}
