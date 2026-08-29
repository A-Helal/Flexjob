import 'package:equatable/equatable.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';

class AppJobEntity extends Equatable {
  const AppJobEntity({
    this.jobs,
    this.current_datetime,
  });

  final JobEntity? jobs;
  final String? current_datetime;

  @override
  List<Object?> get props => <Object?>[];
}
