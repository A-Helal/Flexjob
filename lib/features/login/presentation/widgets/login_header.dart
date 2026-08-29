import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppText(
          text: context.tr(AppLocalizationKeys.welcomeBack),
          style: AppTextStyle.bold_28,
          textColor: Palette.primaryColor,
        ),
        6.heightBox,
        AppText(
          text: context.tr(AppLocalizationKeys.loginSubtitle),
          style: AppTextStyle.regular_16,
          textColor: Palette.grey_757575,
        ),
      ],
    );
  }
}