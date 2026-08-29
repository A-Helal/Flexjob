import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/responsive/app_dimensions.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({
    super.key,
    required this.onNext,
  });

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.pOnly(bottom: 150.h),
      child: CustomElevatedButton(
        width: 0.9.sw,
        height: 45.h,
        text: context.tr(AppLocalizationKeys.onboardingNext),
        textStyle: AppTextStyle.semiBold_16,
        onPressed: onNext,
      ),
    );
  }
}
