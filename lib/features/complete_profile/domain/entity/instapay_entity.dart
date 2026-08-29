import 'package:equatable/equatable.dart';

class InstapayEntity extends Equatable {
  const InstapayEntity({
    required this.payment_address,
  });

  final String? payment_address;

  @override
  List<Object?> get props => <Object?>[];
}
