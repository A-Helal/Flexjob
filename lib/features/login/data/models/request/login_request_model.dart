import 'package:json_annotation/json_annotation.dart';
 
part 'login_request_model.g.dart';

@JsonSerializable()
class LoginRequestModel {
  LoginRequestModel({
    required this.email,
    required this.password,
    this.isGuest = false,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);

  final String email;
  final String password;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool isGuest;

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}