import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LoginRow extends StatelessWidget {
  const LoginRow({super.key, required this.onCompleted});

  final Future<void> Function() onCompleted;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppText(
          text: context.tr(AppLocalizationKeys.alreadyHaveAnAccount),
          style: AppTextStyle.medium_17,
          textAlign: TextAlign.center,
        ),
        5.widthBox,
        _LoginLink(onCompleted: onCompleted),
      ],
    );
  }
}

class _LoginLink extends StatelessWidget {
  const _LoginLink({required this.onCompleted});

  final Future<void> Function() onCompleted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await onCompleted();
        CustomMainRouter.push(LoginRoute());
      },
      child: AppText(
        text: context.tr(AppLocalizationKeys.login),
        textColor: Palette.primaryColor,
        style: AppTextStyle.semiBold_17,
        textAlign: TextAlign.center,
      ),
    );
  }
}
