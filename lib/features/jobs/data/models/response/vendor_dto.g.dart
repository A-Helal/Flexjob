// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorDto _$VendorDtoFromJson(Map<String, dynamic> json) => VendorDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  feesPerHour: json['fees_per_hour'] as num?,
  attachments:
      (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <AttachmentDto>[],
);
