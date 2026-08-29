// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_details_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterDetailsRequestModel _$FilterDetailsRequestModelFromJson(
  Map<String, dynamic> json,
) => FilterDetailsRequestModel(
  id: (json['id'] as List<dynamic>?)?.map((e) => (e as num).toInt()).toList(),
  operator: json['operator'] as String?,
);

Map<String, dynamic> _$FilterDetailsRequestModelToJson(
  FilterDetailsRequestModel instance,
) => <String, dynamic>{'id': instance.id, 'operator': instance.operator};
