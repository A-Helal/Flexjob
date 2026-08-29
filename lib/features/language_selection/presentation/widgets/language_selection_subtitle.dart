import 'package:easy_localization/easy_localization.dart' as context;
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/theming/palette.dart';

class LanguageSelectionSubtitle extends StatelessWidget {
  const LanguageSelectionSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return AppText(
      text: context.tr(AppLocalizationKeys.chooseYourLanguage),
      style: AppTextStyle.medium_19,
      textAlign: TextAlign.center,
      textColor: Palette.primaryColor,
    );
  }
}
