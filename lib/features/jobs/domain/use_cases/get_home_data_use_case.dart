import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/jobs/domain/entities/home_data_entity.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_filter_params.dart';
import 'package:flexiJobs/features/jobs/domain/entities/jobs_list_entity.dart';
import 'package:flexiJobs/features/jobs/domain/entities/upcoming_shift_entity.dart';
import 'package:flexiJobs/features/jobs/domain/repositories/job_repository.dart';
import 'package:injectable/injectable.dart';

/// Assembles home-screen data (job categories, notification count, upcoming
/// shift) by fanning out to three concurrent API calls.
///
/// [userStatus] is supplied by the presentation layer (from the cached user
/// entity) so the domain layer stays free of infrastructure dependencies.
@injectable
class GetHomeDataUseCase {
  const GetHomeDataUseCase({required this.repository});

  final JobRepository repository;

  Future<Either<Failure, HomeDataEntity>> call(
    JobFilterParams params, {
    String? userStatus,
  }) async {
    final bool isApproved = userStatus == 'approved';

    // Fan out all calls concurrently to minimise total round-trip time.
    final Future<Either<Failure, List<JobsListEntity>>> jobsFuture =
        repository.getAvailableJobs(params);

    final Future<int> countFuture = repository.getUnreadNotificationsCount();

    final Future<Either<Failure, UpcomingShiftEntity?>> shiftFuture =
        isApproved
            ? repository.getUpcomingShift()
            : Future<Either<Failure, UpcomingShiftEntity?>>.value(right(null));

    // Await all three in parallel
    await Future.wait<dynamic>(<Future<dynamic>>[
      jobsFuture,
      countFuture,
      shiftFuture,
    ]);

    final Either<Failure, List<JobsListEntity>> jobsResult = await jobsFuture;
    final int count = await countFuture;
    final Either<Failure, UpcomingShiftEntity?> shiftResult =
        await shiftFuture;

    return jobsResult.fold(
      left,
      (List<JobsListEntity> jobs) => right(
        HomeDataEntity(
          jobCategories: jobs,
          unreadNotificationCount: count,
          upcomingShift: shiftResult.fold((_) => null, (s) => s),
        ),
      ),
    );
  }
}
