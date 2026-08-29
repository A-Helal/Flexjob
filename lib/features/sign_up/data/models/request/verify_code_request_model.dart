import 'package:json_annotation/json_annotation.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';

part 'verify_code_request_model.g.dart';

@JsonSerializable()
class VerifyCodeRequestModel{
    VerifyCodeRequestModel({
   required this.code,
   required this.email
  });
  final String code;
 final  String email;
  factory  VerifyCodeRequestModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyCodeRequestModelToJson(this);
}