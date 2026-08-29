import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/notification/domain/entities/notification_entity.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notification});

  final NotificationEntity notification;

  @override
  Widget build(BuildContext context) {
    final _IconTheme theme = _iconThemeFor(notification.category);
    final String timeStr =
        DateFormat('hh:mm', 'en').format(notification.createdAt);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _NotifAvatar(theme: theme),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AppText(
                  text: notification.title,
                  style: AppTextStyle.semiBold_15,
                  textColor: Palette.black_111111,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 3.h),
                AppText(
                  text: notification.description,
                  style: AppTextStyle.regular_13,
                  textColor: Palette.grey_757575,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          AppText(
            text: timeStr,
            style: AppTextStyle.regular_12,
            textColor: Palette.grey_A5A5A5,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Avatar
// ─────────────────────────────────────────────────────────────────────────────

class _NotifAvatar extends StatelessWidget {
  const _NotifAvatar({required this.theme});

  final _IconTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.r,
      height: 44.r,
      decoration: BoxDecoration(
        color: theme.background,
        shape: BoxShape.circle,
      ),
      child: Icon(theme.icon, size: 22.r, color: theme.foreground),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Icon theme logic
// ─────────────────────────────────────────────────────────────────────────────

class _IconTheme {
  const _IconTheme({
    required this.icon,
    required this.background,
    required this.foreground,
  });

  final IconData icon;
  final Color background;
  final Color foreground;
}

_IconTheme _iconThemeFor(NotificationCategory category) {
  switch (category) {
    case NotificationCategory.rejected:
      return const _IconTheme(
        icon: Icons.work_off_rounded,
        background: Color(0xFFFFEBEE),
        foreground: Color(0xFFE53935),
      );
    case NotificationCategory.approved:
      return const _IconTheme(
        icon: Icons.work_rounded,
        background: Color(0xFFE8F5E9),
        foreground: Color(0xFF43A047),
      );
    case NotificationCategory.general:
      return _IconTheme(
        icon: Icons.notifications_rounded,
        background: Palette.secondary.withValues(alpha: 0.12),
        foreground: Palette.secondary,
      );
  }
}
