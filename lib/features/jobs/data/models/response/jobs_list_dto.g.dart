// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobsListDto _$JobsListDtoFromJson(Map<String, dynamic> json) => JobsListDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  jobs:
      (json['jobs'] as List<dynamic>?)
          ?.map((e) => JobDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <JobDto>[],
);
