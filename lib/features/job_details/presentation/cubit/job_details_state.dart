part of 'job_details_cubit.dart';

abstract class JobDetailsState {}

class JobDetailsInitialState extends JobDetailsState {}

class JobDetailsLoadingState extends JobDetailsState {}

class JobDetailsReadyState extends JobDetailsState {
  JobDetailsReadyState({required this.appJobEntity, this.inProgress = false,this.isNeedVideo=false, this.message,this.jobStateType});
  final AppJobEntity appJobEntity;
  bool inProgress;
  bool isNeedVideo;
  final String? message;
  final JobStateType? jobStateType;
}

class JobDetailsErrorState extends JobDetailsState {
  JobDetailsErrorState({
    required this.message,
  });
  final String message;
}
