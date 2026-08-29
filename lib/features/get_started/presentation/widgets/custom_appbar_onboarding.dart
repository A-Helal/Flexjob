import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/responsive/app_dimensions.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/get_started/presentation/cubit/onboarding_cubit.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBarOnboarding extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarOnboarding({
    super.key,
    required this.currentPage,
    required this.pageController,
  });

  final int currentPage;
  final PageController pageController;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.white,
      elevation: 0,
      leading: currentPage > 0
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Palette.primaryColor,
                size: AppDimensions.icon20,
              ),
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            )
          : null,
      actions: <Widget>[
        TextButton(
          onPressed: () => context.read<OnboardingCubit>().completeOnboarding(),
          child: AppText(
            text: context.tr(AppLocalizationKeys.skip),
            style: AppTextStyle.medium_14,
            textColor: Palette.grey_2C2C2C,
          ),
        ),
      ],
    );
  }
}
