// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_notification_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNotificationDto _$UserNotificationDtoFromJson(Map<String, dynamic> json) =>
    UserNotificationDto(
      id: (json['id'] as num).toInt(),
      appUserId: (json['app_user_id'] as num).toInt(),
      notificationId: (json['notification_id'] as num).toInt(),
      isRead: (json['is_read'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
    );

Map<String, dynamic> _$UserNotificationDtoToJson(
  UserNotificationDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'app_user_id': instance.appUserId,
  'notification_id': instance.notificationId,
  'is_read': instance.isRead,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'deleted_at': instance.deletedAt?.toIso8601String(),
};
