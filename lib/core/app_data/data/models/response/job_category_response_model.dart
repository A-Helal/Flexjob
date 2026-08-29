import 'package:flexiJobs/core/app_data/domain/entities/job_category_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';

part 'job_category_response_model.g.dart';

@JsonSerializable()
class JobCategoryModel extends JobCategoryEntity {
  JobCategoryModel({super.id, super.name});
  factory JobCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$JobCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobCategoryModelToJson(this);
}

@JsonSerializable()
class JobCategoryResponseModel extends BaseEntity<List<JobCategoryModel>> {
  JobCategoryResponseModel({
    super.statusCode,
    super.data,
    super.message,
    super.totalRecords,
    super.hasMorePages,
  });
  factory JobCategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$JobCategoryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobCategoryResponseModelToJson(this);
}
