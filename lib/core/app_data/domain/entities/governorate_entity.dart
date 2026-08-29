// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flexiJobs/core/app_data/data/models/response/city_response_model.dart';

class GovernorateEntity extends Equatable {
  const GovernorateEntity({
    this.id,
    this.name,
    this.cities,
  });

  final int? id;
  final String? name;
  final List<CityModel>? cities;
  @override
  List<Object?> get props => <Object?>[];
}
