import 'package:json_annotation/json_annotation.dart';


part 'mobile_wallet_request_model.g.dart';

@JsonSerializable()
class MobileWalletRequestModel{
    MobileWalletRequestModel({required this.type,   this.number,this.card_number});
  final String type;
  final String? number;
  final String? card_number;
  factory  MobileWalletRequestModel.fromJson(Map<String, dynamic> json) =>
      _$MobileWalletRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$MobileWalletRequestModelToJson(this);
}
