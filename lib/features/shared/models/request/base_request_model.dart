import 'package:flexiJobs/features/shared/models/request/filter_request_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_request_model.g.dart';

@JsonSerializable()
class BaseRequestModel {
  BaseRequestModel({
      this.page,
      this.pageSize,
    this.relatedObjects,
    this.filters,
    this.id,
  });
  factory BaseRequestModel.fromJson(Map<String, dynamic> json) =>
      _$BaseRequestModelFromJson(json);

  final int? page;
  @JsonKey(name: "page_size")
  final int? pageSize;
  @JsonKey(name: "related_objects")
  final List<String>? relatedObjects;
  FilterRequestModel? filters;
  final int? id;

  Map<String, dynamic> toJson() => _$BaseRequestModelToJson(this);
}
