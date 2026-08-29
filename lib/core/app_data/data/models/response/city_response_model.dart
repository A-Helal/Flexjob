import 'package:flexiJobs/core/app_data/domain/entities/city_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';

part 'city_response_model.g.dart';

@JsonSerializable()
class CityModel extends CityEntity {
  CityModel({super.governorateId, super.id, super.name});
  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}

@JsonSerializable()
class CityResponseModel extends BaseEntity<CityModel> {
  CityResponseModel({
    super.statusCode,
    super.data,
    super.message,
    super.totalRecords,
    super.hasMorePages,
  });

  factory CityResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CityResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityResponseModelToJson(this);
}
 