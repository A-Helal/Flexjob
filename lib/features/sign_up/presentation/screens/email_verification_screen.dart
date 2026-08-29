import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flexiJobs/features/shared/widgets/master_widget.dart';
import 'package:flexiJobs/features/shared/widgets/underline_text_widget.dart';
import 'package:flexiJobs/features/sign_up/data/models/request/verify_code_request_model.dart';
import 'package:flexiJobs/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:flexiJobs/features/sign_up/presentation/widgets/pin_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexiJobs/core/app_data/presentation/cubit/governorate/governorate_cubit.dart';
import 'package:flexiJobs/core/app_data/presentation/cubit/job_category/job_category_cubit.dart';

@RoutePage()
class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key, required this.email, this.callVerification = false});
  final String email;
  final bool callVerification;
  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool _enablVerifyButton = false;
  SignUpCubit _signUpCubit = getIt<SignUpCubit>();
  CountdownTimerController? controller;
  GovernorateCubit _governorateCubit = getIt<GovernorateCubit>();
  JobCategoryCubit _jobCategoryCubit = getIt<JobCategoryCubit>();
  String? pinCode;

  @override
  void initState() {
    if (widget.callVerification) {
      _signUpCubit.resendCode(email: widget.email);
    }
    controller = CountdownTimerController(
      endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 120,
      onEnd: () {
        setState(() {});
      },
    );
    controller!.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  ViewsToolbox.dismissLoading();
    return BlocProvider<SignUpCubit>.value(
      value: _signUpCubit,
      child: MasterWidget(
        appBar: ViewsToolbox.showAppBar(
          title: context.tr(AppLocalizationKeys.emailVerification),
        ),
        widget: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (BuildContext context, SignUpState state) {
            if (state is ResendCodeReadyState) {
              controller = CountdownTimerController(
                endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 120,
                onEnd: () {
                  setState(() {});
                },
              );
              controller!.start();
              setState(() {});
              ViewsToolbox.dismissLoading();
            } else if (state is SignUpLoadingState) {
              ViewsToolbox.showLoading();
            }
            if (state is SignUpReadyState) {
              if (state.inProgress) {
                ViewsToolbox.showLoading();
              } else {
                ViewsToolbox.dismissLoading();
              }
            }
            if (state is VerifyReadyState) {
              ViewsToolbox.dismissLoading();
              CustomMainRouter.push(NavigationMainRoute(children: <PageRouteInfo>[JobsRoute()]));
              _governorateCubit.getGovernorate();
              _jobCategoryCubit.getJobCategory();
            }
            if (state is SignUpErrorState) {
              ViewsToolbox.dismissLoading();
              ViewsToolbox.showErrorAwesomeSnackBar(context, state.message);
            }
          },
          builder: (BuildContext context, SignUpState state) {
            return Column(
              children: <Widget>[
                130.heightBox,
                Center(
                  child: AppText(
                    style: AppTextStyle.bold_20,
                    textColor: Palette.primaryColor,
                    textAlign: TextAlign.center,
                    text: context.tr(AppLocalizationKeys.verifyYourEmail),
                  ),
                ),
                20.heightBox,
                Center(
                  child: AppText(
                      style: AppTextStyle.medium_14,
                      textAlign: TextAlign.center,
                      textColor: Palette.grey_4C4C4C,
                      text: context.tr(AppLocalizationKeys.enterTheFiveDigitCode)),
                ),
                Center(
                  child: AppText(
                      style: AppTextStyle.medium_14,
                      textAlign: TextAlign.center,
                      textColor: Palette.grey_4C4C4C,
                      text: maskEmail(widget.email)),
                ),
                40.heightBox,
                PinFieldWidget(
                  signUpCubit: _signUpCubit,
                  email: widget.email,
                  controller: controller,
                  onPinCodeCompleted: (bool enabled, String pin) {
                    if (mounted) {
                      setState(() {
                        _enablVerifyButton = enabled;
                        if (enabled) {
                          pinCode = pin;
                        }
                      });
                    }
                  },
                ),
                50.heightBox,
                CustomElevatedButton(
                  onPressed: _enablVerifyButton
                      ? () {
                          _signUpCubit.verifyCode(
                              verifyCodeRequestModel: VerifyCodeRequestModel(code: pinCode!, email: widget.email));
                        }
                      : () {},
                  width: 0.9.sw,
                  backgroundColor: _enablVerifyButton ? null : Palette.grey_F0F0F0,
                  height: 45.h,
                  text: context.tr(AppLocalizationKeys.verifyEmailButton),
                  textStyle: AppTextStyle.semiBold_16,
                ),
                40.heightBox,
                AppText(
                  text: context.tr(
                    AppLocalizationKeys.didNotReceiveEmailWithoutEdit,
                  ),
                  textColor: Palette.grey_2C2C2C,
                  style: AppTextStyle.medium_17,
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  String maskEmail(String email) {
    final List<String> parts = email.split('@');
    final String localPart = parts[0];
    final String domain = parts[1];

    if (localPart.length <= 2) {
      return '**@$domain';
    }

    final String visiblePart = localPart.substring(localPart.length - 2);
    final String maskedPart = '*' * (localPart.length - 2);

    return '$maskedPart$visiblePart@$domain';
  }
}
