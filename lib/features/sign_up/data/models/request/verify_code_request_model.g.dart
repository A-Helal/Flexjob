// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_code_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyCodeRequestModel _$VerifyCodeRequestModelFromJson(
  Map<String, dynamic> json,
) => VerifyCodeRequestModel(
  code: json['code'] as String,
  email: json['email'] as String,
);

Map<String, dynamic> _$VerifyCodeRequestModelToJson(
  VerifyCodeRequestModel instance,
) => <String, dynamic>{'code': instance.code, 'email': instance.email};
