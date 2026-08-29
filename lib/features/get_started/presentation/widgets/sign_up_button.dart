import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key, required this.onCompleted});

  final Future<void> Function() onCompleted;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () async {
        await onCompleted();
        CustomMainRouter.push(SignUpRoute());
      },
      width: 0.9.sw,
      height: 45.h,
      backgroundColor: Palette.transparntColor,
      borderColor: Palette.primaryColor,
      showBorder: true,
      text: context.tr(AppLocalizationKeys.signUp),
      textStyle: AppTextStyle.semiBold_16,
    );
  }
}
