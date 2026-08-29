part of 'jobs_cubit.dart';

sealed class JobsState extends Equatable {
  const JobsState();

  @override
  List<Object?> get props => <Object?>[];
}

class JobsInitial extends JobsState {
  const JobsInitial();
}

class JobsLoading extends JobsState {
  const JobsLoading();
}

class JobsLoaded extends JobsState {
  const JobsLoaded({
    required this.data,
    this.isFiltering = false,
    this.activeFilter,
    this.filterError,
  });

  final HomeDataEntity data;
  final bool isFiltering;
  final JobFilterParams? activeFilter;

  /// Non-null when a governorate filter request failed (optimistic-UI rollback).
  final String? filterError;

  JobsLoaded copyWith({
    HomeDataEntity? data,
    bool? isFiltering,
    JobFilterParams? activeFilter,
    String? filterError,
  }) =>
      JobsLoaded(
        data: data ?? this.data,
        isFiltering: isFiltering ?? this.isFiltering,
        activeFilter: activeFilter ?? this.activeFilter,
        filterError: filterError,
      );

  @override
  List<Object?> get props =>
      <Object?>[data, isFiltering, activeFilter, filterError];
}

class JobsError extends JobsState {
  const JobsError({required this.message});

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
