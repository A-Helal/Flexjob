import 'package:json_annotation/json_annotation.dart';

part 'notification_request_model.g.dart';

@JsonSerializable()
class NotificationRequestModel {
  factory NotificationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationRequestModelFromJson(json);

  const NotificationRequestModel({this.page = 1, this.pageSize = 10});

  final int page;
  @JsonKey(name: 'page_size')
  final int pageSize;

  Map<String, dynamic> toJson() => _$NotificationRequestModelToJson(this);
}
