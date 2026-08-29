import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/forms/image_uploader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HowGetJobWidget extends StatelessWidget {
  const HowGetJobWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: AppText(
            text: context.tr(AppLocalizationKeys.howToGetTheJob),
            style: AppTextStyle.bold_19,
            textColor: Palette.primaryColor,
          ),
        ),
        30.heightBox,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: AppText(
            text: context.tr(AppLocalizationKeys.applyOne),
            style: AppTextStyle.medium_15,
            textColor: Palette.grey_2C2C2C,
          ),
        ),
        30.heightBox,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: AppText(
            text: context.tr(AppLocalizationKeys.applyTwo),
            style: AppTextStyle.medium_15,
            textColor: Palette.grey_2C2C2C,
          ),
        ),
        30.heightBox,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: AppText(
            text: context.tr(AppLocalizationKeys.applyThree),
            style: AppTextStyle.medium_15,
            textColor: Palette.grey_2C2C2C,
          ),
        ),
        30.heightBox,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: AppText(
            text: context.tr(AppLocalizationKeys.applyFour),
            style: AppTextStyle.medium_15,
            textColor: Palette.grey_2C2C2C,
          ),
        ),
        30.heightBox,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: AppText(
            text: context.tr(AppLocalizationKeys.applyFive),
            style: AppTextStyle.medium_15,
            textColor: Palette.grey_2C2C2C,
          ),
        ),
        30.heightBox,
      ],
    );
  }
}
