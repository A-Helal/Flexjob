import 'package:flexiJobs/features/complete_profile/data/models/request/instapay_request_model.dart';
import 'package:flexiJobs/features/complete_profile/data/models/request/mobile_wallet_request_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'complete_payment_info_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CompletePaymentInfoRequestModel{
    CompletePaymentInfoRequestModel({
    required this.paymentable_type,
      this.instapays,
      this.mobile_wallets,
      this.pre_paid_cards
  });
  final String paymentable_type;
  final InstapayRequestModel? instapays;
  final MobileWalletRequestModel? mobile_wallets;
  final MobileWalletRequestModel? pre_paid_cards;
  factory  CompletePaymentInfoRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CompletePaymentInfoRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompletePaymentInfoRequestModelToJson(this);
}
