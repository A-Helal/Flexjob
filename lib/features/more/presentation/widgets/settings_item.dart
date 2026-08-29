import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.showDivider = true,
    this.labelColor,
    this.iconColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool showDivider;
  final Color? labelColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: !showDivider
                ? BorderRadius.only(
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            )
                : BorderRadius.zero,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 14.h,
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      color: (iconColor ?? Palette.primaryColor)
                          .withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      icon,
                      size: 18.sp,
                      color: iconColor ?? Palette.primaryColor,
                    ),
                  ),
                  14.widthBox,
                  Expanded(
                    child: AppText(
                      text: label,
                      style: AppTextStyle.medium_15,
                      textColor: labelColor ?? const Color(0xFF2C2C2C),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14.sp,
                    color: const Color(0xFFCCCCCC),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: const Color(0xFFF0F0F0),
            indent: 20.w,
            endIndent: 20.w,
          ),
      ],
    );
  }
}