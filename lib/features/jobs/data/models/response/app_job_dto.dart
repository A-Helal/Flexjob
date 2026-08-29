import 'package:flexiJobs/features/jobs/data/models/response/job_dto.dart';
import 'package:flexiJobs/features/jobs/domain/entities/app_job_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_job_dto.g.dart';

@JsonSerializable(createToJson: false)
class AppJobDto {
  factory AppJobDto.fromJson(Map<String, dynamic> json) =>
      _$AppJobDtoFromJson(json);

  const AppJobDto({this.currentDatetime, this.job});

  @JsonKey(name: 'current_datetime')
  final String? currentDatetime;

  @JsonKey(name: 'jobs')
  final JobDto? job;

  JobDto? get jobDto => job;

  AppJobEntity toEntity() => AppJobEntity(
    jobs: job?.toEntity(),
    current_datetime: currentDatetime,
  );
}
