// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class PaymentEntity extends Equatable {
  const PaymentEntity({
    this.id,
    this.type,
    this.cardNumber,
    this.number,
    this.payment_address,
    this.appUserId,
  });

  final int? id;
  final String? type;
  final String? number;
  final String? payment_address;
  @JsonKey(name: "card_number")
  final String? cardNumber;
  @JsonKey(name: "app_user_id")
  final int? appUserId;

  @override
  List<Object?> get props => <Object?>[];
}
