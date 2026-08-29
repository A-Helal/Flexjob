// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_payment_info_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletePaymentInfoRequestModel _$CompletePaymentInfoRequestModelFromJson(
  Map<String, dynamic> json,
) => CompletePaymentInfoRequestModel(
  paymentable_type: json['paymentable_type'] as String,
  instapays: json['instapays'] == null
      ? null
      : InstapayRequestModel.fromJson(
          json['instapays'] as Map<String, dynamic>,
        ),
  mobile_wallets: json['mobile_wallets'] == null
      ? null
      : MobileWalletRequestModel.fromJson(
          json['mobile_wallets'] as Map<String, dynamic>,
        ),
  pre_paid_cards: json['pre_paid_cards'] == null
      ? null
      : MobileWalletRequestModel.fromJson(
          json['pre_paid_cards'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$CompletePaymentInfoRequestModelToJson(
  CompletePaymentInfoRequestModel instance,
) => <String, dynamic>{
  'paymentable_type': instance.paymentable_type,
  'instapays': instance.instapays?.toJson(),
  'mobile_wallets': instance.mobile_wallets?.toJson(),
  'pre_paid_cards': instance.pre_paid_cards?.toJson(),
};
