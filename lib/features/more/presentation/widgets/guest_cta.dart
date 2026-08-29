import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestCta extends StatelessWidget {
  const GuestCta({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.person_add_alt_1_rounded,
            color: Palette.primaryColor,
            size: 36.sp,
          ),
          12.heightBox,
          AppText(
            text: context.tr(AppLocalizationKeys.createAccountGuest),
            style: AppTextStyle.medium_14,
            textColor: const Color(0xFF8A8A9A),
            textAlign: TextAlign.center,
          ),
          16.heightBox,
          SizedBox(
            width: double.infinity,
            height: 44.h,
            child: ElevatedButton(
              onPressed: () => CustomMainRouter.push(SignUpRoute()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: AppText(
                text: context.tr(AppLocalizationKeys.signUp),
                style: AppTextStyle.semiBold_15,
                textColor: Colors.white,
              ),
            ),
          ),
          12.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppText(
                text: context.tr(AppLocalizationKeys.alreadyHaveAnAccount),
                style: AppTextStyle.regular_13,
                textColor: const Color(0xFF8A8A9A),
              ),
              4.widthBox,
              GestureDetector(
                onTap: () => CustomMainRouter.push(LoginRoute()),
                child: AppText(
                  text: context.tr(AppLocalizationKeys.login),
                  style: AppTextStyle.semiBold_13,
                  textColor: Palette.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
