import 'package:flexiJobs/features/jobs/data/models/response/attachment_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flexiJobs/features/jobs/domain/entities/vendor_entity.dart';

part 'vendor_dto.g.dart';

@JsonSerializable(createToJson: false)
class VendorDto {

  factory VendorDto.fromJson(Map<String, dynamic> json) =>
      _$VendorDtoFromJson(json);
  const VendorDto({
    required this.id,
    required this.name,
    this.feesPerHour,
    this.attachments = const <AttachmentDto>[],
  });

  final int id;
  final String name;
  @JsonKey(name: 'fees_per_hour')
  final num? feesPerHour;
  final List<AttachmentDto> attachments;

  VendorEntity toEntity() {
    final AttachmentDto? logo = attachments.firstOrNull;
    return VendorEntity(
      id: id,
      name: name,
      feesPerHour: feesPerHour?.toDouble(),
      logoUrl: logo?.path,
      attachments: attachments.map((a) => a.toEntity()).toList(),
    );
  }
}