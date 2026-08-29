// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'create_new_password_request_model.g.dart';

@JsonSerializable()
class CreateNewPasswordRequestModel {
  CreateNewPasswordRequestModel({
    this.password,
    this.confirm_password,
    this.token,
    this.old_password,
  });

  final String? password;
  // ignore: non_constant_identifier_names
  final String? confirm_password;
  // ignore: non_constant_identifier_names
  final String? old_password;
  final String? token;

  factory CreateNewPasswordRequestModel.fromJson(
          Map<String, dynamic> json) =>
      _$CreateNewPasswordRequestModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateNewPasswordRequestModelToJson(this);
}
