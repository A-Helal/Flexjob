import 'package:flexiJobs/core/responsive/app_dimensions.dart';
import 'package:flexiJobs/core/responsive/app_spacing.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({
    super.key,
    required this.illustration,
    required this.title,
    required this.description,
  });

  final Widget illustration;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.pH24,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: illustration,
          ),
          AppSpacing.v40,
          AppText(
            text: title,
            textAlign: TextAlign.center,
            style: AppTextStyle.bold_22,
            textColor: Palette.primaryColor,
          ),
          AppSpacing.v16,
          AppText(
            text: description,
            textAlign: TextAlign.center,
            style: AppTextStyle.regular_14,
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
