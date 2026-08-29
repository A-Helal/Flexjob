// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_personal_info_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletePersonalInfoRequestModel _$CompletePersonalInfoRequestModelFromJson(
  Map<String, dynamic> json,
) => CompletePersonalInfoRequestModel(
  name: json['name'] as String,
  phone_code: json['phone_code'] as String,
  phone_number: json['phone_number'] as String,
  birthdate: json['birthdate'] as String,
  address: json['address'] as String,
  gender: json['gender'] as String,
  governorate_id: (json['governorate_id'] as num).toInt(),
  city_id: (json['city_id'] as num).toInt(),
  national_id: json['national_id'] as String,
  university_id: (json['university_id'] as num?)?.toInt(),
  university_name: json['university_name'] as String?,
  university_faculty: json['university_faculty'] as String,
  university_major: json['university_major'] as String,
);

Map<String, dynamic> _$CompletePersonalInfoRequestModelToJson(
  CompletePersonalInfoRequestModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'phone_code': instance.phone_code,
  'phone_number': instance.phone_number,
  'birthdate': instance.birthdate,
  'address': instance.address,
  'gender': instance.gender,
  'governorate_id': instance.governorate_id,
  'city_id': instance.city_id,
  'national_id': instance.national_id,
  'university_faculty': instance.university_faculty,
  'university_major': instance.university_major,
  'university_id': instance.university_id,
  'university_name': instance.university_name,
};
