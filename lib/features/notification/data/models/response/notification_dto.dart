import 'package:flexiJobs/features/notification/data/models/response/user_notification_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flexiJobs/features/notification/domain/entities/notification_entity.dart';

part 'notification_dto.g.dart';

@JsonSerializable()
class NotificationDto {

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);
  const NotificationDto({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.hyperLink,
    this.notificationSent,
    this.type,
    this.isForAll,
    this.updatedAt,
    this.deletedAt,
    this.userNotification,
  });

  final int id;
  final String title;
  final String description;
  @JsonKey(name: 'hyper_link')
  final String? hyperLink;
  @JsonKey(name: 'notification_sent')
  final String? notificationSent;
  /// Optional type string from the API (e.g. "approved", "rejected").
  final String? type;
  @JsonKey(name: 'is_for_all')
  final int? isForAll;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;
  @JsonKey(name: 'a_u_notification')
  final UserNotificationDto? userNotification;

  Map<String, dynamic> toJson() => _$NotificationDtoToJson(this);

  NotificationEntity toEntity() => NotificationEntity(
    id: id,
    title: title.trim().isEmpty ? '—' : title,
    description: description,
    hyperLink: hyperLink,
    notificationSent: notificationSent,
    type: type,
    isForAll: (isForAll ?? 0) == 1,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    userNotification: userNotification?.toEntity(),
  );
}