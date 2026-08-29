import 'package:equatable/equatable.dart';

class PrePaidCardEntity extends Equatable {
  const PrePaidCardEntity({
    required this.type,
    required this.card_number,
  });
  final String? type;
  final String? card_number;

  @override
  List<Object?> get props => <Object?>[];
}
