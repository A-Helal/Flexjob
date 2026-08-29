import 'package:flexiJobs/features/get_started/presentation/widgets/onboarding_footer_actions.dart';
import 'package:flexiJobs/features/login/presentation/cubit/login_cubit.dart';
import 'package:flutter/material.dart';

class OnboardingFooterSwitcher extends StatelessWidget {
  const OnboardingFooterSwitcher({
    super.key,
    required this.pageIndex,
    required this.lastPage,
    required this.loginCubit,
  });

  final int pageIndex;
  final int lastPage;
  final LoginCubit loginCubit;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 280),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (Widget child, Animation<double> animation) =>
          FadeTransition(opacity: animation, child: child),
      child: pageIndex == lastPage
          ? OnboardingFooterActions(
        key: const ValueKey<String>('onboarding_actions'),
        loginCubit: loginCubit,
      )
          : const SizedBox(
        key: ValueKey<String>('onboarding_actions_placeholder'),
      ),
    );
  }
}