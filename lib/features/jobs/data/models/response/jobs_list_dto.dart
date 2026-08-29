import 'package:flexiJobs/features/jobs/data/models/response/job_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flexiJobs/features/jobs/domain/entities/jobs_list_entity.dart';

part 'jobs_list_dto.g.dart';

@JsonSerializable(createToJson: false)
class JobsListDto {
  factory JobsListDto.fromJson(Map<String, dynamic> json) =>
      _$JobsListDtoFromJson(json);

  const JobsListDto({
    required this.id,
    required this.name,
    this.jobs = const <JobDto>[],
  });

  final int id;
  final String name;
  final List<JobDto> jobs;

  JobsListEntity toEntity() => JobsListEntity(
    id: id,
    name: name,
    jobs: jobs.map((j) => j.toEntity()).toList(),
  );
}
