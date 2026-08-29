// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_wallet_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MobileWalletRequestModel _$MobileWalletRequestModelFromJson(
  Map<String, dynamic> json,
) => MobileWalletRequestModel(
  type: json['type'] as String,
  number: json['number'] as String?,
  card_number: json['card_number'] as String?,
);

Map<String, dynamic> _$MobileWalletRequestModelToJson(
  MobileWalletRequestModel instance,
) => <String, dynamic>{
  'type': instance.type,
  'number': instance.number,
  'card_number': instance.card_number,
};
