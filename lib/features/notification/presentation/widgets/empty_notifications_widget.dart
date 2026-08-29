import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyNotificationsWidget extends StatelessWidget {
  const EmptyNotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.notifications_off_outlined,
              size: 72.r,
              color: Palette.grey_757575.withValues(alpha: 0.5),
            ),
            SizedBox(height: 20.h),
            Text(
              context.tr(AppLocalizationKeys.noNotifications),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Palette.primaryColor,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              context.tr(AppLocalizationKeys.noNotificationsSubtitle),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Palette.grey_757575,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}