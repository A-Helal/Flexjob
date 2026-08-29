import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/app_data/presentation/cubit/user/user_cubit.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/use_helper.dart';
import 'package:flexiJobs/features/more/presentation/widgets/delete_account_dialog.dart';
import 'package:flexiJobs/features/more/presentation/widgets/guest_cta.dart';
import 'package:flexiJobs/features/more/presentation/widgets/logout_button.dart';
import 'package:flexiJobs/features/more/presentation/widgets/settings_card.dart';
import 'package:flexiJobs/features/more/presentation/widgets/settings_item.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/cubit/locale_cubit/locale_cubit.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';

class MoreBody extends StatelessWidget {
  const MoreBody({
    super.key,
    required this.localeCubit,
    required this.userCubit,
    required this.onProfileReturned,
    this.dialogContext,
  });

  final LocaleCubit localeCubit;
  final UserCubit userCubit;
  final VoidCallback onProfileReturned;
  final BuildContext? dialogContext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: <Widget>[
          50.heightBox,
          if (UseHelper.isGuest()) ...<Widget>[GuestCta(), 24.heightBox],
          if (!UseHelper.isGuest()) ...<Widget>[
            SettingsCard(
              title: context.tr(AppLocalizationKeys.account),
              items: <SettingsItem>[
                SettingsItem(
                  icon: Icons.person_outline_rounded,
                  label: context.tr(AppLocalizationKeys.profile),
                  showDivider: true,
                  onTap: () => CustomMainRouter.push(
                    CompleteProfileRoute(),
                    then: (_) => onProfileReturned(),
                  ),
                ),
                SettingsItem(
                  icon: Icons.video_camera_front_outlined,
                  label: context.tr(AppLocalizationKeys.introVideo),
                  showDivider: true,
                  onTap: () => CustomMainRouter.push(IntroductionVideoRoute()),
                ),
                SettingsItem(
                  icon: Icons.lock_outline_rounded,
                  label: context.tr(AppLocalizationKeys.changePassword),
                  showDivider: false,
                  onTap: () => CustomMainRouter.push(ChangePasswordRoute()),
                ),
              ],
            ),
            20.heightBox,
          ],
          SettingsCard(
            title: context.tr(AppLocalizationKeys.app),
            items: <SettingsItem>[
              SettingsItem(
                icon: Icons.language_rounded,
                label: context.tr(AppLocalizationKeys.changeLanguage),
                showDivider: true,
                onTap: () {
                  final bool isEn =
                      localeCubit.getCurrentLocale() ==
                      const Locale('en', 'US');
                  localeCubit.setLocale(
                    context,
                    isEn ? const Locale('ar', 'KW') : const Locale('en', 'US'),
                  );
                },
              ),
              SettingsItem(
                icon: Icons.description_outlined,
                label: context.tr(AppLocalizationKeys.termsAndConditions),
                showDivider: true,
                onTap: () => ViewsToolbox.launchUrlHelper(
                  'https://flexijobapp.com/terms-and-conditions',
                ),
              ),
              SettingsItem(
                icon: Icons.info_outline_rounded,
                label: context.tr(AppLocalizationKeys.aboutUs),
                showDivider: !UseHelper.isGuest(),
                onTap: () => CustomMainRouter.push(const AboutUsRoute()),
              ),
              if (!UseHelper.isGuest())
                SettingsItem(
                  icon: Icons.delete_outline_rounded,
                  label: context.tr(AppLocalizationKeys.deleteAccount),
                  showDivider: false,
                  labelColor: Colors.red.shade400,
                  iconColor: Colors.red.shade400,
                  onTap: () =>
                      DeleteAccountDialog.show(context, userCubit: userCubit),
                ),
            ],
          ),
          10.heightBox,
          if (!UseHelper.isGuest()) LogoutButton(),
          20.heightBox,
          AppText(
            text: 'App Version 1.00',
            style: AppTextStyle.regular_12,
            textColor: const Color(0xFFBBBBBB),
            textAlign: TextAlign.center,
          ),
          32.heightBox,
        ],
      ),
    );
  }
}
