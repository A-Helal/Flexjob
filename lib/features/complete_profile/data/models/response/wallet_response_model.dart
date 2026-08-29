import 'package:flexiJobs/features/complete_profile/domain/entity/pre_paid_card_entity.dart';
import 'package:json_annotation/json_annotation.dart';


part 'wallet_response_model.g.dart';

@JsonSerializable()
class WalletResponseModel extends PrePaidCardEntity {
    WalletResponseModel({
    super.card_number,
    super.type  
  });
  factory  WalletResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WalletResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalletResponseModelToJson(this);
}

