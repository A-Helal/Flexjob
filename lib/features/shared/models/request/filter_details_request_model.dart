import 'package:json_annotation/json_annotation.dart';
 
part 'filter_details_request_model.g.dart';

@JsonSerializable()
class FilterDetailsRequestModel{
    FilterDetailsRequestModel({
      required this.id,
      required this.operator,
    
  });
  factory  FilterDetailsRequestModel.fromJson(Map<String, dynamic> json) =>
      _$FilterDetailsRequestModelFromJson(json);
  final List<int>? id;
  final String? operator;
  Map<String, dynamic> toJson() => _$FilterDetailsRequestModelToJson(this);
}