import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/assets_paths.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/features/language_selection/presentation/widgets/language_option_item.dart';
import 'package:flutter/material.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import '../../domain/entities/app_language.dart';
import '../cubit/language_selection_cubit.dart';

class LanguageOptionList extends StatelessWidget {
  const LanguageOptionList({super.key, required this.state});

  final LanguageSelectionState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        LanguageOptionItem(
          title: context.tr(AppLocalizationKeys.languageEnglishLabel),
          assetPath: AssetsPaths.flagEnglish,
          language: AppLanguage.english,
          selected: state.selected == AppLanguage.english,
        ),
        16.heightBox,
        LanguageOptionItem(
          title: context.tr(AppLocalizationKeys.languageArabicLabel),
          assetPath: AssetsPaths.flagArabic,
          language: AppLanguage.arabic,
          selected: state.selected == AppLanguage.arabic,
        ),
      ],
    );
  }
}
