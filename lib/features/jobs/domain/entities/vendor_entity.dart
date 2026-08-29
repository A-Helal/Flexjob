import 'package:equatable/equatable.dart';
import 'package:flexiJobs/features/jobs/domain/entities/attachment_entity.dart';

class VendorEntity extends Equatable {
  const VendorEntity({
    required this.id,
    required this.name,
    this.feesPerHour,
    this.logoUrl,
    this.attachments = const <AttachmentEntity>[],
  });

  final int id;
  final String name;
  final double? feesPerHour;
  final String? logoUrl;
  final List<AttachmentEntity> attachments;

  @override
  List<Object?> get props => <Object?>[id, name, feesPerHour, logoUrl];
}
