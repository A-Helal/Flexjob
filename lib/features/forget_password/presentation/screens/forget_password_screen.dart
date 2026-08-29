import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:flexiJobs/features/forget_password/presentation/widgets/create_new_password_widget.dart';
import 'package:flexiJobs/features/forget_password/presentation/widgets/enter_email_form_widget.dart';
import 'package:flexiJobs/features/forget_password/presentation/widgets/verify_email_widget.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/features/shared/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

@RoutePage()
class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();
  final ForgetPasswordCubit _forgetPasswordCubit =
      getIt<ForgetPasswordCubit>();
  CountdownTimerController? _controller;

  @override
  void dispose() {
    _controller?.disposeTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _key,
      child: MasterWidget(
        scaffoldColor: Palette.grey_FAFAFA,
        appBar: ViewsToolbox.showAppBar(
          title: context.tr(AppLocalizationKeys.passwordReset),
        ),
        widget: BlocProvider<ForgetPasswordCubit>.value(
          value: _forgetPasswordCubit,
          child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
            listener: (BuildContext context, ForgetPasswordState state) {
              if (state is ForgetPasswordReadyState) {
                if (state.inProgress!) {
                  ViewsToolbox.showLoading();
                } else {
                  ViewsToolbox.dismissLoading();
                }
                if (state.fromVerify!) {
                  _controller = CountdownTimerController(
                    endTime: DateTime.now().millisecondsSinceEpoch +
                        const Duration(minutes: 2).inMilliseconds,
                    onEnd: () => setState(() {}),
                  )..start();
                  setState(() {});
                }
                if (state.passwordChanged!) {
                  ViewsToolbox.showSuccessAwesomeSnackBar(
                    context,
                    context.tr(
                        AppLocalizationKeys.passwordChangedSuccessfully),
                  );
                  CustomMainRouter.pop();
                }
                if (state.errorMessage != null) {
                  ViewsToolbox.dismissLoading();
                  ViewsToolbox.showErrorAwesomeSnackBar(
                      context, state.errorMessage!);
                }
              }
            },
            builder: (BuildContext context, ForgetPasswordState state) {
              if (state is ForgetPasswordReadyState) {
                if (state.verifyStep!) {
                  return VerifyEmailWidget(
                    forgetPasswordCubit: _forgetPasswordCubit,
                    email: state.email!,
                    controller: _controller,
                  );
                } else if (state.createNewPasswordStep!) {
                  return CreateNewPasswordFormWidget(
                    forgetPasswordCubit: _forgetPasswordCubit,
                    token: state.token!,
                  );
                } else if (state.enterEmailStep!) {
                  return EnterEmailFormWidget(
                    forgetPasswordCubit: _forgetPasswordCubit,
                  );
                }
              }
              return EnterEmailFormWidget(
                forgetPasswordCubit: _forgetPasswordCubit,
              );
            },
          ),
        ),
      ),
    );
  }
}
