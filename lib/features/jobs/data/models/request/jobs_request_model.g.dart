// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobsRequestModel _$JobsRequestModelFromJson(Map<String, dynamic> json) =>
    JobsRequestModel(
      page: (json['page'] as num?)?.toInt() ?? 1,
      pageSize: (json['page_size'] as num?)?.toInt() ?? 100,
      governorateId: (json['governorate_id'] as num?)?.toInt(),
      jobCategoryId: (json['job_category_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$JobsRequestModelToJson(JobsRequestModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'page_size': instance.pageSize,
      'governorate_id': ?instance.governorateId,
      'job_category_id': ?instance.jobCategoryId,
    };
