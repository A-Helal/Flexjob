import 'package:auto_route/auto_route.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/features/get_started/presentation/widgets/custom_appbar_onboarding.dart';
import 'package:flexiJobs/features/get_started/presentation/widgets/onboarding_bloc_providers.dart';
import 'package:flexiJobs/features/get_started/presentation/widgets/onboarding_footer_switcher.dart';
import 'package:flexiJobs/features/get_started/presentation/widgets/onboarding_next_button.dart';
import 'package:flexiJobs/features/get_started/presentation/widgets/onboarding_slider.dart';
import 'package:flexiJobs/features/login/presentation/cubit/login_cubit.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  final LoginCubit _loginCubit = getIt<LoginCubit>();
  late final PageController _pageController;
  int _pageIndex = 0;

  static const int _lastPage = OnboardingSlider.pageCount - 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_pageIndex >= _lastPage) return;
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) => setState(() => _pageIndex = index);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: OnboardingBlocProviders(
        loginCubit: _loginCubit,
        child: Scaffold(
          backgroundColor: Palette.white,
          appBar: CustomAppBarOnboarding(
            currentPage: _pageIndex,
            pageController: _pageController,
          ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: OnboardingSlider(
                    controller: _pageController,
                    currentPageIndex: _pageIndex,
                    onPageChanged: _onPageChanged,
                  ),
                ),
                if (_pageIndex < _lastPage)
                  OnboardingNextButton(onNext: _nextPage),
                OnboardingFooterSwitcher(
                  pageIndex: _pageIndex,
                  lastPage: _lastPage,
                  loginCubit: _loginCubit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
