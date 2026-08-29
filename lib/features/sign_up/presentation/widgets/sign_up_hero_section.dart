import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/assets_paths.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';

class SignUpHeroSection extends StatelessWidget {
  const SignUpHeroSection({super.key, required this.fadeAnim});

  final Animation<double> fadeAnim;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.28.sh,
      width: double.infinity,
      child: Center(
        child: FadeTransition(
          opacity: fadeAnim,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(AssetsPaths.hello, height: 80.h),
              16.heightBox,
              AppText(
                text: context.tr(AppLocalizationKeys.createYourAccount),
                style: AppTextStyle.bold_22,
                textColor: Palette.primaryColor,
                textAlign: TextAlign.center,
              ),
              6.heightBox,
              AppText(
                text: context.tr(AppLocalizationKeys.signUpSubtitle),
                style: AppTextStyle.regular_13,
                textColor: Palette.primaryColor.withValues(alpha: 0.8),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
