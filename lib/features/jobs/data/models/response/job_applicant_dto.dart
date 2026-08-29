import 'package:json_annotation/json_annotation.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_applicant_entity.dart';

part 'job_applicant_dto.g.dart';

@JsonSerializable(createToJson: false)
class JobApplicantDto {
  factory JobApplicantDto.fromJson(Map<String, dynamic> json) =>
      _$JobApplicantDtoFromJson(json);

  const JobApplicantDto({required this.id, this.status});

  final int id;
  final String? status;

  JobApplicantEntity toEntity() => JobApplicantEntity(id: id, status: status);
}
