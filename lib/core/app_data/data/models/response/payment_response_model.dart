import 'package:flexiJobs/core/app_data/domain/entities/paymentable_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';

part 'payment_response_model.g.dart';

@JsonSerializable()
class PaymentModel extends PaymentEntity {
    PaymentModel({
    super.appUserId,
    super.cardNumber,
    super.id,
    super.type,
    super.number,
    super.payment_address,
  });
  factory  PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}

@JsonSerializable()
class PaymentResponseModel extends BaseEntity<PaymentModel> {
   PaymentResponseModel({
    super.statusCode,
    super.data,
    super.message,
    super.totalRecords,
    super.hasMorePages,
  });
  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentResponseModelToJson(this);
}
