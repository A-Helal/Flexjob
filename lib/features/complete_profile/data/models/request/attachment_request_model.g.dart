// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentRequestModel _$AttachmentRequestModelFromJson(
  Map<String, dynamic> json,
) => AttachmentRequestModel(
  filePath: json['filePath'] as String,
  type: json['type'] as String,
);

Map<String, dynamic> _$AttachmentRequestModelToJson(
  AttachmentRequestModel instance,
) => <String, dynamic>{'filePath': instance.filePath, 'type': instance.type};
