import 'package:equatable/equatable.dart';

class UserNotificationEntity extends Equatable {
  const UserNotificationEntity({
    required this.id,
    required this.appUserId,
    required this.notificationId,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  final int id;
  final int appUserId;
  final int notificationId;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  @override
  List<Object?> get props => <Object?>[id, appUserId, notificationId, isRead, createdAt, updatedAt, deletedAt];
}