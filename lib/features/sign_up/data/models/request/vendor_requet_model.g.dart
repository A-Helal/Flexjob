// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_requet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorRequestModel _$VendorRequestModelFromJson(Map<String, dynamic> json) =>
    VendorRequestModel(
      email: json['email'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      position: json['position'] as String?,
      fullName: json['full_name'] as String?,
    );

Map<String, dynamic> _$VendorRequestModelToJson(VendorRequestModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'phone_number': instance.phoneNumber,
      'position': instance.position,
      'full_name': instance.fullName,
    };
