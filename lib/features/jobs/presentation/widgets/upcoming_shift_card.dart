import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/jobs/domain/entities/upcoming_shift_entity.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Renamed from NotifyShiftCard — clearer, typo-free filename.
class UpcomingShiftCard extends StatelessWidget {
  const UpcomingShiftCard({super.key, required this.shift, required this.onTap});

  final UpcomingShiftEntity shift;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 54.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Palette.primaryColor, Palette.blue_292F89, Palette.blue_4450BB],
          ),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Palette.primaryColor.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              "assets/svg/bell.svg",
              width: 22.w,
              colorFilter: ColorFilter.mode(Palette.white, BlendMode.srcIn),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: AppText(
                style: AppTextStyle.semiBold_15,
                textColor: Palette.white,
                text: context.tr(
                  AppLocalizationKeys.yourShift,
                  args: [shift.upcomingShiftStartIn ?? ''],
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: Palette.white, size: 14.r),
          ],
        ),
      ),
    );
  }
}