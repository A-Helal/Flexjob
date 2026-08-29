import 'package:flexiJobs/features/shared/models/request/filter_details_request_model.dart';
import 'package:json_annotation/json_annotation.dart';
 
part 'filter_request_model.g.dart';

@JsonSerializable()
class FilterRequestModel{
    FilterRequestModel( {
    this.cities, this.job_categories,
  });
  factory  FilterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$FilterRequestModelFromJson(json);
final FilterDetailsRequestModel? cities;
final FilterDetailsRequestModel? job_categories;

  Map<String, dynamic> toJson() => _$FilterRequestModelToJson(this);
}