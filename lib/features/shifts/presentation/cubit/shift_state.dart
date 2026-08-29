// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'shift_cubit.dart';

abstract class ShiftState {}

class ShiftInitialState extends ShiftState {}

class ShiftLoadingState extends ShiftState {}

class ShiftReadyState extends ShiftState {
  ShiftReadyState({
    required this.jobs,
    this.inProgress = false,
    required this.total,
    this.jobComingShiftEntity,
    this.pageNumber = 1,
  });

  final List<JobEntity> jobs;
  final bool inProgress;
  final int total;
  final UpcomingShiftEntity? jobComingShiftEntity;
  final int pageNumber;

  ShiftReadyState copyWith({
    List<JobEntity>? jobs,
    bool? inProgress,
    int? total,
    UpcomingShiftEntity? jobComingShiftEntity,
    int? pageNumber,
  }) =>
      ShiftReadyState(
        jobs: jobs ?? this.jobs,
        inProgress: inProgress ?? this.inProgress,
        total: total ?? this.total,
        jobComingShiftEntity: jobComingShiftEntity ?? this.jobComingShiftEntity,
        pageNumber: pageNumber ?? this.pageNumber,
      );
}

class ShiftErrorState extends ShiftState {
  ShiftErrorState({required this.message});

  final String message;
}

class ProfileUnderReviewState extends ShiftState {}
