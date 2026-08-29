// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_new_password_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateNewPasswordRequestModel _$CreateNewPasswordRequestModelFromJson(
  Map<String, dynamic> json,
) => CreateNewPasswordRequestModel(
  password: json['password'] as String?,
  confirm_password: json['confirm_password'] as String?,
  token: json['token'] as String?,
  old_password: json['old_password'] as String?,
);

Map<String, dynamic> _$CreateNewPasswordRequestModelToJson(
  CreateNewPasswordRequestModel instance,
) => <String, dynamic>{
  'password': instance.password,
  'confirm_password': instance.confirm_password,
  'old_password': instance.old_password,
  'token': instance.token,
};
