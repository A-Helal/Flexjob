import 'package:equatable/equatable.dart';
import 'package:flexiJobs/features/notification/domain/entities/user_notification_entity.dart';

/// Semantic category for a notification, derived from its title/type field.
/// Prefer setting this from the API `type` field when available; fall back to
/// title-based inference only when necessary.
enum NotificationCategory {
  rejected,
  approved,
  general,
}

class NotificationEntity extends Equatable {
  const NotificationEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.hyperLink,
    this.notificationSent,
    this.type,
    this.isForAll = false,
    this.updatedAt,
    this.deletedAt,
    this.userNotification,
  });

  final int id;
  final String title;
  final String description;
  final String? hyperLink;
  final String? notificationSent;

  /// Optional explicit type string coming from the API (e.g. "approved", "rejected").
  /// When present, [category] is derived from this field. When absent, the
  /// category falls back to title-based inference.
  final String? type;

  final bool isForAll;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final UserNotificationEntity? userNotification;

  bool get isUnread => userNotification == null || !userNotification!.isRead;

  /// Semantic category for icon/color theming, derived from [type] when
  /// available, otherwise inferred from [title].
  NotificationCategory get category {
    final String src = (type ?? title).toLowerCase();
    if (src.contains('reject') || src.contains('رفض') || src.contains('مرفوض')) {
      return NotificationCategory.rejected;
    }
    if (src.contains('approv') || src.contains('accept') || src.contains('قبول') || src.contains('مقبول')) {
      return NotificationCategory.approved;
    }
    return NotificationCategory.general;
  }

  @override
  List<Object?> get props => <Object?>[id, title, description, hyperLink, isForAll, createdAt, userNotification, type];
}