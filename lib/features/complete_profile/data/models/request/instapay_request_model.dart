import 'package:json_annotation/json_annotation.dart';


part 'instapay_request_model.g.dart';

@JsonSerializable()
class InstapayRequestModel{
    InstapayRequestModel({
    required this.payment_address
  });
  final String payment_address;
  factory  InstapayRequestModel.fromJson(Map<String, dynamic> json) =>
      _$InstapayRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$InstapayRequestModelToJson(this);
}
