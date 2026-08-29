// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
  appUserId: (json['app_user_id'] as num?)?.toInt(),
  cardNumber: json['card_number'] as String?,
  id: (json['id'] as num?)?.toInt(),
  type: json['type'] as String?,
  number: json['number'] as String?,
  payment_address: json['payment_address'] as String?,
);

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'number': instance.number,
      'payment_address': instance.payment_address,
      'card_number': instance.cardNumber,
      'app_user_id': instance.appUserId,
    };

PaymentResponseModel _$PaymentResponseModelFromJson(
  Map<String, dynamic> json,
) => PaymentResponseModel(
  statusCode: (json['statusCode'] as num?)?.toInt(),
  data: json['data'] == null
      ? null
      : PaymentModel.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String?,
  totalRecords: (json['totalRecords'] as num?)?.toInt(),
  hasMorePages: json['hasMorePages'] as bool?,
);

Map<String, dynamic> _$PaymentResponseModelToJson(
  PaymentResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'statusCode': instance.statusCode,
  'data': instance.data,
  'totalRecords': instance.totalRecords,
  'hasMorePages': instance.hasMorePages,
};
