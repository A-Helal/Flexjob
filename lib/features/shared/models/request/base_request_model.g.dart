// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseRequestModel _$BaseRequestModelFromJson(Map<String, dynamic> json) =>
    BaseRequestModel(
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['page_size'] as num?)?.toInt(),
      relatedObjects: (json['related_objects'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      filters: json['filters'] == null
          ? null
          : FilterRequestModel.fromJson(
              json['filters'] as Map<String, dynamic>,
            ),
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BaseRequestModelToJson(BaseRequestModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'page_size': instance.pageSize,
      'related_objects': instance.relatedObjects,
      'filters': instance.filters,
      'id': instance.id,
    };
