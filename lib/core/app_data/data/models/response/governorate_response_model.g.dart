// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'governorate_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GovernorateModel _$GovernorateModelFromJson(Map<String, dynamic> json) =>
    GovernorateModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      cities: (json['cities'] as List<dynamic>?)
          ?.map((e) => CityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GovernorateModelToJson(GovernorateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cities': instance.cities,
    };

GovernorateResponseModel _$GovernorateResponseModelFromJson(
  Map<String, dynamic> json,
) => GovernorateResponseModel(
  statusCode: (json['statusCode'] as num?)?.toInt(),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => GovernorateModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
  totalRecords: (json['totalRecords'] as num?)?.toInt(),
  hasMorePages: json['hasMorePages'] as bool?,
);

Map<String, dynamic> _$GovernorateResponseModelToJson(
  GovernorateResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'statusCode': instance.statusCode,
  'data': instance.data,
  'totalRecords': instance.totalRecords,
  'hasMorePages': instance.hasMorePages,
};
