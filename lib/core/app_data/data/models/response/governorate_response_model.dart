import 'package:flexiJobs/core/app_data/data/models/response/city_response_model.dart';
import 'package:flexiJobs/core/app_data/domain/entities/governorate_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';

part 'governorate_response_model.g.dart';

@JsonSerializable()
class GovernorateModel extends GovernorateEntity {
  GovernorateModel({
    super.id,
    super.name,
    super.cities,
  });
  factory GovernorateModel.fromJson(Map<String, dynamic> json) =>
      _$GovernorateModelFromJson(json);

  Map<String, dynamic> toJson() => _$GovernorateModelToJson(this);
}

@JsonSerializable()
class GovernorateResponseModel extends BaseEntity<List<GovernorateModel>> {
    GovernorateResponseModel({
    super.statusCode,
    super.data,
    super.message,
    super.totalRecords,
    super.hasMorePages,
  });
  factory GovernorateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GovernorateResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GovernorateResponseModelToJson(this);
}
