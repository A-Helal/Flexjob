// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletResponseModel _$WalletResponseModelFromJson(Map<String, dynamic> json) =>
    WalletResponseModel(
      card_number: json['card_number'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$WalletResponseModelToJson(
  WalletResponseModel instance,
) => <String, dynamic>{
  'type': instance.type,
  'card_number': instance.card_number,
};
