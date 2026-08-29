part of 'job_list_cubit.dart';

abstract class JobListState {}

class JobListInitialState extends JobListState {}

class JobListLoadingState extends JobListState {}

class JobListReadyState extends JobListState {
  JobListReadyState({
    this.inProgress = false,
    this.total,
    this.catgoryId,
    this.jobList,
    this.pageNumber,
  });
  final bool? inProgress;
  final List<JobEntity>? jobList;
  final int? total;
  final int? catgoryId;
  final int? pageNumber;
}

class JobListErrorState extends JobListState {
  JobListErrorState({
    required this.message,
  });
  final String message;
}
