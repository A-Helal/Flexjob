// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentDto _$AttachmentDtoFromJson(Map<String, dynamic> json) =>
    AttachmentDto(
      id: (json['id'] as num).toInt(),
      path: json['path'] as String,
      fileName: json['file_name'] as String?,
      type: json['type'] as String?,
      attachmentableType: json['attachmentable_type'] as String?,
      attachmentableId: (json['attachmentable_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AttachmentDtoToJson(AttachmentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'path': instance.path,
      'file_name': instance.fileName,
      'type': instance.type,
      'attachmentable_type': instance.attachmentableType,
      'attachmentable_id': instance.attachmentableId,
    };
