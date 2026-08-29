import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateProfilePopUp {
  static void showConfirmPopUp(BuildContext context, {required void Function() onYesTap}) {
    showDefualtDialog(
        title: context.tr(AppLocalizationKeys.UpdateYourProfile),
        message: context.tr(AppLocalizationKeys.anyChanges),
        onYesTapText: context.tr(AppLocalizationKeys.yesContinue),
        onNoTapText: context.tr(AppLocalizationKeys.notNow),
        onYesTap: onYesTap,
        dialogContext: context);
  }

  static void showShouldUpdatePopUp(BuildContext context, {required void Function() onYesTap}) {
    showDefualtDialog(
        title: context.tr(AppLocalizationKeys.UpdateYourProfile),
        message: context.tr(AppLocalizationKeys.missingParmas),
        onYesTapText: context.tr(AppLocalizationKeys.UpdateYourProfile),
        onNoTapText: context.tr(AppLocalizationKeys.notNow),
        onYesTap: onYesTap,
        dialogContext: context);
  }

  static void showDefualtDialog({
    required String title,
    required String message,
    required String onYesTapText,
    required String onNoTapText,
    required VoidCallback onYesTap,
    required BuildContext? dialogContext,
  }) {
    ViewsToolbox.showCustomDialog(
        dialogContext: dialogContext!,
        widgets: <Widget>[
          AppText(
            text: title,
            textColor: Palette.primaryColor,
            style: AppTextStyle.bold_17,
            textAlign: TextAlign.center,
          ),
          20.heightBox,
          AppText(
            text: message,
            textColor: Palette.black,
            style: AppTextStyle.medium_14,
            textAlign: TextAlign.center,
          ),
          20.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomElevatedButton(
                onPressed: () {
                  CustomMainRouter.pop();
                },
                width: 0.2.sw,
                backgroundColor: Palette.transparntColor,
                borderColor: Palette.grey_F0F0F0,
                height: 30.h,
                text: onNoTapText,
                textColor: Palette.black,
                showBorder: true,
                textStyle: AppTextStyle.medium_12,
              ),
              10.widthBox,
              CustomElevatedButton(
                onPressed: onYesTap,
                width: 0.4.sw,
                height: 30.h,
                backgroundColor: Palette.secondary,
                text: onYesTapText,
                textStyle: AppTextStyle.medium_12,
              ),
            ],
          )
        ],
        getDialogContext: (BuildContext context) => dialogContext);
  }
}
