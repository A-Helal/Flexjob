// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_job_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppJobDto _$AppJobDtoFromJson(Map<String, dynamic> json) => AppJobDto(
  currentDatetime: json['current_datetime'] as String?,
  job: json['jobs'] == null
      ? null
      : JobDto.fromJson(json['jobs'] as Map<String, dynamic>),
);
