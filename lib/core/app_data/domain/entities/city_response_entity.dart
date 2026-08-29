import 'package:equatable/equatable.dart';
import 'package:flexiJobs/core/app_data/data/models/response/city_response_model.dart';

class CityResponseEntity extends Equatable {
  const CityResponseEntity({this.cities});

  final CityModel? cities;
  @override
  List<Object?> get props => <Object?>[];
}
