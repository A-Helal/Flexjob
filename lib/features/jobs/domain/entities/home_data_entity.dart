import 'package:equatable/equatable.dart';
import 'package:flexiJobs/features/jobs/domain/entities/jobs_list_entity.dart';
import 'package:flexiJobs/features/jobs/domain/entities/upcoming_shift_entity.dart';

class HomeDataEntity extends Equatable {
  const HomeDataEntity({
    required this.jobCategories,
    required this.unreadNotificationCount,
    this.upcomingShift,
  });

  HomeDataEntity copyWith({
    List<JobsListEntity>? jobCategories,
    int? unreadNotificationCount,
    UpcomingShiftEntity? upcomingShift,
  }) => HomeDataEntity(
    jobCategories: jobCategories ?? this.jobCategories,
    unreadNotificationCount:
        unreadNotificationCount ?? this.unreadNotificationCount,
    upcomingShift: upcomingShift ?? this.upcomingShift,
  );
  final List<JobsListEntity> jobCategories;
  final int unreadNotificationCount;
  final UpcomingShiftEntity? upcomingShift;

  List<JobsListEntity> get nonEmptyCategories =>
      jobCategories.where((JobsListEntity c) => c.hasJobs).toList();

  @override
  List<Object?> get props => <Object?>[
    jobCategories,
    unreadNotificationCount,
    upcomingShift,
  ];
}
