import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';

class SignUpRow extends StatelessWidget {
  const SignUpRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppText(
          text: context.tr(AppLocalizationKeys.notRegistered),
          style: AppTextStyle.regular_15,
          textColor: Palette.grey_757575,
        ),
        6.widthBox,
        GestureDetector(
          onTap: () => CustomMainRouter.push(SignUpRoute()),
          child: AppText(
            text: context.tr(AppLocalizationKeys.signup),
            style: AppTextStyle.semiBold_14,
            textColor: Palette.purple_8E29DE,
          ),
        ),
      ],
    );
  }
}
