import 'package:json_annotation/json_annotation.dart';
import 'package:flexiJobs/features/notification/domain/entities/user_notification_entity.dart';

part 'user_notification_dto.g.dart';

@JsonSerializable()
class UserNotificationDto {
  const UserNotificationDto({
    required this.id,
    required this.appUserId,
    required this.notificationId,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  final int id;
  @JsonKey(name: 'app_user_id')
  final int appUserId;
  @JsonKey(name: 'notification_id')
  final int notificationId;
  @JsonKey(name: 'is_read')
  final int isRead; // kept as int here — mapping to bool happens in mapper
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  factory UserNotificationDto.fromJson(Map<String, dynamic> json) =>
      _$UserNotificationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserNotificationDtoToJson(this);

  UserNotificationEntity toEntity() => UserNotificationEntity(
    id: id,
    appUserId: appUserId,
    notificationId: notificationId,
    isRead: isRead == 1, // ← conversion lives here, not in UI
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
  );
}