import 'package:json_annotation/json_annotation.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';

part 'vendor_requet_model.g.dart';

@JsonSerializable()
class VendorRequestModel{
    VendorRequestModel({
    this.email,
    this.name,
    this.phoneNumber,
    this.position,
    this.fullName,
  });

  final String? email;
  final String? name;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @JsonKey(name: 'position')
  final String? position;

  @JsonKey(name: 'full_name')
  final String? fullName;
  factory  VendorRequestModel.fromJson(Map<String, dynamic> json) =>
      _$VendorRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$VendorRequestModelToJson(this);
}