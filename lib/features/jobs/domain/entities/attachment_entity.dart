import 'package:equatable/equatable.dart';

class AttachmentEntity extends Equatable {
  const AttachmentEntity({
    required this.id,
    required this.path,
    this.fileName,
    this.type,
  });

  final int id;
  final String path;
  final String? fileName;
  final String? type;

  @override
  List<Object?> get props => [id, path, fileName, type];
}