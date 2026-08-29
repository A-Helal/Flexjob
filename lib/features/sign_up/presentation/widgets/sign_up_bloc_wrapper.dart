import 'package:auto_route/src/route/page_route_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/features/login/presentation/cubit/login_cubit.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

class SignUpBlocWrapper extends StatelessWidget {
  const SignUpBlocWrapper({
    super.key,
    required this.signUpCubit,
    required this.loginCubit,
    required this.onVendorEmailSent,
    required this.child,
  });

  final SignUpCubit signUpCubit;
  final LoginCubit loginCubit;
  final VoidCallback onVendorEmailSent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<SignUpCubit>.value(value: signUpCubit),
        BlocProvider<LoginCubit>.value(value: loginCubit),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<SignUpCubit, SignUpState>(listener: _handleSignUpState),
          BlocListener<LoginCubit, LoginState>(listener: _handleLoginState),
        ],
        child: child,
      ),
    );
  }

  void _handleSignUpState(BuildContext context, SignUpState state) {
    if (state is SignUpLoadingState) {
      ViewsToolbox.showLoading();
    } else if (state is SignUpReadyState) {
      ViewsToolbox.dismissLoading();
      CustomMainRouter.push(EmailVerificationRoute(email: state.email));
    } else if (state is SignUpErrorState) {
      ViewsToolbox.dismissLoading();
      ViewsToolbox.showErrorAwesomeSnackBar(context, state.message);
    } else if (state is SendVendorEmailReadyState) {
      ViewsToolbox.dismissLoading();
      ViewsToolbox.showSuccessAwesomeSnackBar(
        context,
        context.tr(AppLocalizationKeys.emailSentSuccessfully),
      );
      onVendorEmailSent();
    }
  }

  void _handleLoginState(BuildContext context, LoginState state) {
    if (state is LoginLoadingState) {
      ViewsToolbox.showLoading();
    } else if (state is LoginReadyState) {
      ViewsToolbox.dismissLoading();
      CustomMainRouter.push(
        NavigationMainRoute(children: <PageRouteInfo<Object?>>[JobsRoute()]),
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
