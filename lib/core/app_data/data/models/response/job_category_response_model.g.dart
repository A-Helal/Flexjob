// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_category_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobCategoryModel _$JobCategoryModelFromJson(Map<String, dynamic> json) =>
    JobCategoryModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$JobCategoryModelToJson(JobCategoryModel instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

JobCategoryResponseModel _$JobCategoryResponseModelFromJson(
  Map<String, dynamic> json,
) => JobCategoryResponseModel(
  statusCode: (json['statusCode'] as num?)?.toInt(),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => JobCategoryModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
  totalRecords: (json['totalRecords'] as num?)?.toInt(),
  hasMorePages: json['hasMorePages'] as bool?,
);

Map<String, dynamic> _$JobCategoryResponseModelToJson(
  JobCategoryResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'statusCode': instance.statusCode,
  'data': instance.data,
  'totalRecords': instance.totalRecords,
  'hasMorePages': instance.hasMorePages,
};
