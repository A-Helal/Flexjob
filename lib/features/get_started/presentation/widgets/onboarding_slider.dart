import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/constants/assets_paths.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/features/get_started/presentation/widgets/onboarding_item.dart';
import 'package:flexiJobs/features/get_started/presentation/widgets/page_indicator_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingSlider extends StatelessWidget {
  const OnboardingSlider({
    required this.controller,
    required this.currentPageIndex,
    required this.onPageChanged,
    super.key,
  });

  final PageController controller;
  final int currentPageIndex;
  final ValueChanged<int> onPageChanged;
  static const int pageCount = 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: PageView(
            controller: controller,
            onPageChanged: onPageChanged,
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              OnboardingItem(
                illustration: SvgPicture.asset(
                  AssetsPaths.onBoarding1,
                  fit: BoxFit.contain,
                  height: 0.3.sh,
                ),
                title: context.tr(AppLocalizationKeys.allMiniJobsInOnePlace),
                description: context.tr(AppLocalizationKeys.stopLooking),
              ),
              OnboardingItem(
                illustration: SvgPicture.asset(
                  AssetsPaths.secondOnBoarding,
                  fit: BoxFit.contain,
                  height: 0.3.sh,
                ),
                title: context.tr(AppLocalizationKeys.createYourProfileEasily),
                description: context.tr(AppLocalizationKeys.enablingEffortless),
              ),
              OnboardingItem(
                illustration: SvgPicture.asset(
                  AssetsPaths.thirdOnBoarding,
                  fit: BoxFit.contain,
                  height: 0.3.sh,
                ),
                title: context.tr(AppLocalizationKeys.applyToTheSuitableJobYou),
                description: context.tr(AppLocalizationKeys.simpleJobApplication),
              ),
            ],
          ),
        ),
        16.heightBox,
        PageIndicatorDots(pageCount: pageCount, currentPage: currentPageIndex),
        28.heightBox,
      ],
    );
  }
}
