import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';

class SavedRightsText extends StatelessWidget {
  const SavedRightsText({super.key});

  @override
  Widget build(BuildContext context) {
    return AppText(
      text: context.tr(AppLocalizationKeys.savedRights),
      style: AppTextStyle.regular_14,
      textAlign: TextAlign.center,
      textColor: Palette.grey_2C2C2C,
    );
  }
}
