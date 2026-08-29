import 'package:flexiJobs/features/complete_profile/domain/entity/instapay_entity.dart';
import 'package:json_annotation/json_annotation.dart';


part 'instapay_response_model.g.dart';

@JsonSerializable()
class InstapayResponseModel extends InstapayEntity {
    InstapayResponseModel({
    super.payment_address
  });
  factory  InstapayResponseModel.fromJson(Map<String, dynamic> json) =>
      _$InstapayResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$InstapayResponseModelToJson(this);
}

