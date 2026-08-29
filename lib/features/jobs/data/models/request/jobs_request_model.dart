import 'package:json_annotation/json_annotation.dart';

part 'jobs_request_model.g.dart';

@JsonSerializable(includeIfNull: false)
class JobsRequestModel {

  factory JobsRequestModel.fromJson(Map<String, dynamic> json) =>
      _$JobsRequestModelFromJson(json);
  const JobsRequestModel({
    this.page = 1,
    this.pageSize = 100,
    this.governorateId,
    this.jobCategoryId,
  });

  final int page;
  @JsonKey(name: 'page_size')
  final int pageSize;
  @JsonKey(name: 'governorate_id')
  final int? governorateId;
  @JsonKey(name: 'job_category_id')
  final int? jobCategoryId;

  Map<String, dynamic> toJson() => _$JobsRequestModelToJson(this);
}
