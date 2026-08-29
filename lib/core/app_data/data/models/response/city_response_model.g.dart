// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityModel _$CityModelFromJson(Map<String, dynamic> json) => CityModel(
  governorateId: (json['governorate_id'] as num?)?.toInt(),
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
);

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'governorate_id': instance.governorateId,
};

CityResponseModel _$CityResponseModelFromJson(Map<String, dynamic> json) =>
    CityResponseModel(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : CityModel.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      totalRecords: (json['totalRecords'] as num?)?.toInt(),
      hasMorePages: json['hasMorePages'] as bool?,
    );

Map<String, dynamic> _$CityResponseModelToJson(CityResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'statusCode': instance.statusCode,
      'data': instance.data,
      'totalRecords': instance.totalRecords,
      'hasMorePages': instance.hasMorePages,
    };
