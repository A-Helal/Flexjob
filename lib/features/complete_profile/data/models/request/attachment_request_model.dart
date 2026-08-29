import 'package:json_annotation/json_annotation.dart';


part 'attachment_request_model.g.dart';

@JsonSerializable()
class AttachmentRequestModel{
    AttachmentRequestModel({
    required this.filePath,
    required this.type
  });

  final String filePath;
  final String type;
  factory  AttachmentRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AttachmentRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentRequestModelToJson(this);
}
