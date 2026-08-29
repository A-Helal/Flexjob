// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  email: json['email'] as String?,
  id: (json['id'] as num?)?.toInt(),
  userableId: (json['userableId'] as num?)?.toInt(),
  userableType: json['userableType'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'userableType': instance.userableType,
  'userableId': instance.userableId,
};

UserResponseModel _$UserResponseModelFromJson(Map<String, dynamic> json) =>
    UserResponseModel(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : UserModel.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      totalRecords: (json['totalRecords'] as num?)?.toInt(),
      hasMorePages: json['hasMorePages'] as bool?,
    );

Map<String, dynamic> _$UserResponseModelToJson(UserResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'statusCode': instance.statusCode,
      'data': instance.data,
      'totalRecords': instance.totalRecords,
      'hasMorePages': instance.hasMorePages,
    };
