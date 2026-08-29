import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/use_helper.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isGuest = UseHelper.isGuest();
    final String code = LocalData.user?.code != null
        ? 'ID ${LocalData.user!.code}'
        : '';

    if (isGuest) return const SizedBox.shrink();

    return Column(
      children: <Widget>[
        AppText(
          text: code,
          style: AppTextStyle.medium_14,
          textColor: const Color(0xFF8A8A9A),
          textAlign: TextAlign.center,
        ),
        6.heightBox,
        const _VerifiedBadge(),
      ],
    );
  }
}

class _VerifiedBadge extends StatelessWidget {
  const _VerifiedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Palette.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Palette.primaryColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.verified_rounded,
            color: Palette.primaryColor,
            size: 14.sp,
          ),
          5.widthBox,
          AppText(
            text: context.tr(AppLocalizationKeys.verifiedAccount),
            style: AppTextStyle.medium_12,
            textColor: Palette.primaryColor,
          ),
        ],
      ),
    );
  }
}