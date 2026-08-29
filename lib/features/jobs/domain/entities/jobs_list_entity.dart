import 'package:equatable/equatable.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';

class JobsListEntity extends Equatable {
  const JobsListEntity({
    required this.id,
    required this.name,
    this.jobs = const <JobEntity>[],
  });

  final int id;
  final String name;
  final List<JobEntity> jobs;

  bool get hasJobs => jobs.isNotEmpty;

  @override
  List<Object?> get props => <Object?>[id, name, jobs];
}