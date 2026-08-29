// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class CityEntity extends Equatable {
  const CityEntity({
    this.id,
    this.name,
    this.governorateId,
  });

  final int? id;
  final String? name;
  @JsonKey(name: "governorate_id")
  final int? governorateId;

  @override
  List<Object?> get props => <Object?>[];
}
