import 'package:auto_route/auto_route.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/features/get_started/presentation/cubit/onboarding_cubit.dart';
import 'package:flexiJobs/features/login/presentation/cubit/login_cubit.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingBlocProviders extends StatelessWidget {
  const OnboardingBlocProviders({
    super.key,
    required this.loginCubit,
    required this.child,
  });

  final LoginCubit loginCubit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingCubit>(
      create: (_) => OnboardingCubit(),
      child: BlocListener<OnboardingCubit, OnboardingState>(
        listenWhen: (OnboardingState previous, OnboardingState current) {
          final bool nowCompleted = current.maybeWhen(
            completed: () => true,
            orElse: () => false,
          );
          final bool wasCompleted = previous.maybeWhen(
            completed: () => true,
            orElse: () => false,
          );
          return nowCompleted && !wasCompleted;
        },
        listener: (BuildContext context, OnboardingState state) {
          state.maybeWhen(
            completed: () {
              LocalData.setHasCompletedOnboarding(true).then((_) {
                CustomMainRouter.appRouter.replace(LoginRoute());
              });
            },
            orElse: () {},
          );
        },
        child: BlocProvider<LoginCubit>.value(
          value: loginCubit,
          child: BlocListener<LoginCubit, LoginState>(
            listener: _handleLoginState,
            child: child,
          ),
        ),
      ),
    );
  }

  void _handleLoginState(BuildContext context, LoginState state) {
    if (state is LoginLoadingState) {
      ViewsToolbox.showLoading();
    } else if (state is LoginReadyState) {
      ViewsToolbox.dismissLoading();
      CustomMainRouter.push(
        NavigationMainRoute(children: <PageRouteInfo>[JobsRoute()]),
      );
    } else if (state is EmailVervicationNeededReadyState) {
      ViewsToolbox.dismissLoading();
      CustomMainRouter.push(
        EmailVerificationRoute(email: state.email, callVerification: true),
      );
    } else if (state is LoginErrorState) {
      ViewsToolbox.dismissLoading();
      ViewsToolbox.showErrorAwesomeSnackBar(context, state.message);
    }
  }
}
