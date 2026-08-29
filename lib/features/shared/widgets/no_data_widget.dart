import 'package:auto_route/src/route/page_route_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'app_text.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    super.key,
    this.hideButton = false,
  });
  final bool hideButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        100.heightBox,
        SvgPicture.asset(
          'assets/svg/introOne.svg',
          width: 250.w,
        ),
        40.heightBox,
        AppText(
          text: context.tr(AppLocalizationKeys.noJobsAvailable),
          style: AppTextStyle.bold_22,
        ),
        20.heightBox,
        hideButton
            ? Container()
            : AppText(
                text: context.tr(AppLocalizationKeys.startApplyingToYourFirstJob),
                style: AppTextStyle.regular_15,
              ),
        20.heightBox,
        hideButton
            ? Container()
            : CustomElevatedButton(
                onPressed: LocalData.user!.is_guest == 1
                    ? () {
                        CustomMainRouter.push(SignUpRoute());
                      }
                    : () {
                        LocalData.user != null && LocalData.user!.status == null
                            ? CustomMainRouter.push(CompleteProfileRoute())
                            : CustomMainRouter.push(NavigationMainRoute(children: <PageRouteInfo>[JobsRoute()]));
                      },
                width: 0.9.sw,
                height: 45.h,
                text: LocalData.user!.is_guest == 1
                    ? context.tr(AppLocalizationKeys.signUp)
                    : LocalData.user != null && LocalData.user!.status == null
                        ? context.tr(AppLocalizationKeys.completeYourProfileToApply)
                        : context.tr(AppLocalizationKeys.applyNow),
                textStyle: AppTextStyle.semiBold_16,
              ),
      ],
    );
  }
}
