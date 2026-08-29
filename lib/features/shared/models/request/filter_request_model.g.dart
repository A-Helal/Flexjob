// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterRequestModel _$FilterRequestModelFromJson(Map<String, dynamic> json) =>
    FilterRequestModel(
      cities: json['cities'] == null
          ? null
          : FilterDetailsRequestModel.fromJson(
              json['cities'] as Map<String, dynamic>,
            ),
      job_categories: json['job_categories'] == null
          ? null
          : FilterDetailsRequestModel.fromJson(
              json['job_categories'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$FilterRequestModelToJson(FilterRequestModel instance) =>
    <String, dynamic>{
      'cities': instance.cities,
      'job_categories': instance.job_categories,
    };
