// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    this.id,
    this.email,
    this.userableType,
    this.userableId,
  });

  final int? id;
  final String? email;
  final String? userableType;
  final int? userableId;

  @override
  List<Object?> get props => <Object?>[];
}
