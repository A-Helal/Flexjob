// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationDto _$NotificationDtoFromJson(Map<String, dynamic> json) =>
    NotificationDto(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      hyperLink: json['hyper_link'] as String?,
      notificationSent: json['notification_sent'] as String?,
      type: json['type'] as String?,
      isForAll: (json['is_for_all'] as num?)?.toInt(),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      userNotification: json['a_u_notification'] == null
          ? null
          : UserNotificationDto.fromJson(
              json['a_u_notification'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$NotificationDtoToJson(NotificationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'hyper_link': instance.hyperLink,
      'notification_sent': instance.notificationSent,
      'type': instance.type,
      'is_for_all': instance.isForAll,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'a_u_notification': instance.userNotification,
    };
