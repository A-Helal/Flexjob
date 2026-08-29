import 'package:json_annotation/json_annotation.dart';
import 'package:flexiJobs/features/jobs/domain/entities/attachment_entity.dart';

part 'attachment_dto.g.dart';

@JsonSerializable()
class AttachmentDto {
  factory AttachmentDto.fromJson(Map<String, dynamic> json) =>
      _$AttachmentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentDtoToJson(this);

  const AttachmentDto({
    required this.id,
    required this.path,
    this.fileName,
    this.type,
    this.attachmentableType,
    this.attachmentableId,
  });

  final int id;
  final String path;
  @JsonKey(name: 'file_name')
  final String? fileName;
  final String? type;
  @JsonKey(name: 'attachmentable_type')
  final String? attachmentableType;
  @JsonKey(name: 'attachmentable_id')
  final int? attachmentableId;

  AttachmentEntity toEntity() =>
      AttachmentEntity(id: id, path: path, fileName: fileName, type: type);
}
