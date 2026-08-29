// import 'package:easy_localization/easy_localization.dart' as context;
// import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
// import 'package:flexiJobs/core/constants/app_localization_keys.dart';
// import 'package:flexiJobs/core/theming/palette.dart';

class LanguageSelectionHeader extends StatelessWidget {
  const LanguageSelectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/png/FLEXIJOBlongtext.png");
  }
}

//Column(
//       children: <Widget>[
//         Image.asset("assets/png/FLEXIJOBlongtext.png"),
//         AppText(
//           text: context.tr(AppLocalizationKeys.appSubTitle),
//           style: AppTextStyle.semiBold_17,
//           textAlign: TextAlign.center,
//           textColor: Palette.purple_8E29DE,
//         ),
//       ],
//     );
