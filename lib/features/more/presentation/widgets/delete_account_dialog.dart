import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/app_data/presentation/cubit/user/user_cubit.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteAccountDialog {
  static void show(BuildContext context, {required UserCubit userCubit}) {
    ViewsToolbox.showCustomDialog(
      dialogContext: context,
      widgets: <Widget>[
        AppText(
          text: context.tr(AppLocalizationKeys.deleteAccount),
          textColor: Palette.primaryColor,
          style: AppTextStyle.bold_17,
          textAlign: TextAlign.center,
        ),
        20.heightBox,
        AppText(
          text: context.tr(AppLocalizationKeys.areYouSureWantToDelete),
          textColor: Palette.black,
          style: AppTextStyle.medium_14,
          textAlign: TextAlign.center,
        ),
        20.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomElevatedButton(
              onPressed: () => CustomMainRouter.pop(),
              width: 0.33.sw,
              height: 36.h,
              showBorder: true,
              backgroundColor: Palette.transparntColor,
              borderColor: Palette.grey_F0F0F0,
              text: context.tr(AppLocalizationKeys.keepAccount),
              textStyle: AppTextStyle.medium_12,
            ),
            10.widthBox,
            CustomElevatedButton(
              onPressed: () {
                CustomMainRouter.pop();
                _showConfirmDialog(context, userCubit: userCubit);
              },
              width: 0.33.sw,
              backgroundColor: Colors.red.shade400,
              height: 36.h,
              text: context.tr(AppLocalizationKeys.yesDelete),
              textStyle: AppTextStyle.medium_12,
            ),
          ],
        ),
      ],
      getDialogContext: (_) {},
    );
  }

  static void _showConfirmDialog(
    BuildContext context, {
    required UserCubit userCubit,
  }) {
    ViewsToolbox.showCustomDialog(
      dialogContext: context,
      widgets: <Widget>[
        AppText(
          text: context.tr(AppLocalizationKeys.requestDeleteAccount),
          textColor: Palette.primaryColor,
          style: AppTextStyle.bold_17,
          textAlign: TextAlign.center,
        ),
        20.heightBox,
        AppText(
          text: context.tr(AppLocalizationKeys.afterSubmitting),
          textColor: Palette.black,
          style: AppTextStyle.medium_14,
          textAlign: TextAlign.center,
        ),
        20.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomElevatedButton(
              onPressed: () => CustomMainRouter.pop(),
              width: 0.33.sw,
              height: 36.h,
              showBorder: true,
              backgroundColor: Palette.transparntColor,
              borderColor: Palette.grey_F0F0F0,
              text: context.tr(AppLocalizationKeys.cancel),
              textStyle: AppTextStyle.medium_12,
            ),
            10.widthBox,
            CustomElevatedButton(
              onPressed: () {
                CustomMainRouter.pop();
                ViewsToolbox.showLoading();
                userCubit.deleteUser();
              },
              width: 0.33.sw,
              backgroundColor: Palette.secondary,
              height: 36.h,
              text: context.tr(AppLocalizationKeys.submitRequest),
              textStyle: AppTextStyle.medium_12,
            ),
          ],
        ),
      ],
      getDialogContext: (_) {},
    );
  }
}
