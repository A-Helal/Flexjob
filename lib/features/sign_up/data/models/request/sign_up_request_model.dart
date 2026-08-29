import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request_model.g.dart';

@JsonSerializable()
class SignUpRequestModel{
    SignUpRequestModel( {required this.email, required this.password,
    
  });
 
  factory  SignUpRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestModelFromJson(json);
 final String email;
  final String password;
  Map<String, dynamic> toJson() => _$SignUpRequestModelToJson(this);
}