import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BadgeIcon extends StatelessWidget {
  const BadgeIcon({super.key, required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Palette.primaryColor.withValues(alpha: 0.69),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.notifications_none_outlined,
                size: 28.w,
                color: Palette.white,
              ),
            ),
          ),
        ),
        if (count > 0)
          Positioned(
            left: isRtl ? 20 : null,
            right: isRtl ? null : 20,
            top: 8,
            child: Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: Palette.redBackgroundTheme,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: AppText(
                  text: count > 99 ? '99+' : count.toString(),
                  textColor: Palette.white,
                  style: AppTextStyle.semiBold_12,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
