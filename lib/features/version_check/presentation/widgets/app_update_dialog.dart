import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/theming/theme.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flexiJobs/features/version_check/helpers/version_comparison_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateDialog {
  /// Shows app update dialog
  /// [isMandatory] - if true, dialog cannot be cancelled
  static Future<void> show({
    required BuildContext context,
    required bool isMandatory,
  }) async {
    BuildContext? dialogContext;

    await ViewsToolbox.showCustomDialog(
      dialogContext: context,
      getDialogContext: (BuildContext ctx) {
        dialogContext = ctx;
      },
      showCloseIcon: !isMandatory, // Show close icon only if not mandatory
      allowDismiss: !isMandatory, // Allow dismiss only if not mandatory
      widgets: [
        // App icon or update icon
        Icon(
          Icons.system_update,
          size: 60.w,
          color: Palette.primaryColor,
        ),
        20.heightBox,

        // Title
        AppText(
          text: isMandatory ? "update_required".tr() : "update_available".tr(),
          style: AppTextStyle.bold_17,
          textColor: Palette.primaryColor,
          textAlign: TextAlign.center,
        ),
        15.heightBox,

        // Message
        AppText(
          text: isMandatory
              ? "mandatory_update_message".tr()
              : "optional_update_message".tr(),
          style: AppTextStyle.medium_14,
          textColor: Palette.black,
          textAlign: TextAlign.center,
        ),
        25.heightBox,

        // Update button
        CustomElevatedButton(
          text: "update_now".tr(),
          textColor: Palette.white,
          backgroundColor: Palette.primaryColor,
          onPressed: () {
            final storeUrl = VersionComparisonHelper.getStoreUrl();
            _launchStore(storeUrl);
          },
        ),

        // Cancel button (only for optional updates)
        if (!isMandatory) ...[
          10.heightBox,
          CustomElevatedButton(
            text: "later".tr(),
            backgroundColor: Palette.transparntColor,
            borderColor: Palette.grey_F0F0F0,
            textColor: Palette.lightBlack,
            showBorder: true,
            onPressed: () {
              if (dialogContext != null) {
                Navigator.pop(dialogContext!);
              }
            },
          ),
        ],
      ],
    );
  }

  /// Launches the app store
  static Future<void> _launchStore(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
