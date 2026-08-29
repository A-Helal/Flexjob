// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';



part 'complete_personal_info_request_model.g.dart';

@JsonSerializable()
class CompletePersonalInfoRequestModel {
  CompletePersonalInfoRequestModel({
    required this.name,
    required this.phone_code,
    required this.phone_number,
    required this.birthdate,
    required this.address,
    required this.gender,
    required this.governorate_id,
    required this.city_id,
    required this.national_id,
    this.attachment,
    this.university_id,
    this.university_name,
    required this.university_faculty,
    required this.university_major,
  });

  final String name;
  final String phone_code;
  final String phone_number;

  final String birthdate;
  final String address;
  final String gender;
  final int governorate_id;
  final int city_id;
  final String national_id;
  final String university_faculty;
  final String university_major;
  final int? university_id;
  final String? university_name;
  @JsonKey(includeFromJson: false)
  FormData? attachment;

  factory CompletePersonalInfoRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CompletePersonalInfoRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompletePersonalInfoRequestModelToJson(this);
}

