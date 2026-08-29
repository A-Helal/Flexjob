import 'package:auto_route/src/route/page_route_info.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/features/login/presentation/cubit/login_cubit.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBlocWrapper extends StatelessWidget {
  const LoginBlocWrapper({
    super.key,
    required this.loginCubit,
    required this.child,
  });

  final LoginCubit loginCubit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>.value(
      value: loginCubit,
      child: BlocListener<LoginCubit, LoginState>(
        listener: (BuildContext context, LoginState state) {
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
              EmailVerificationRoute(
                email: state.email,
                callVerification: true,
              ),
            );
          } else if (state is LoginErrorState) {
            ViewsToolbox.dismissLoading();
            ViewsToolbox.showErrorAwesomeSnackBar(context, state.message);
          }
        },
        child: child,
      ),
    );
  }
}