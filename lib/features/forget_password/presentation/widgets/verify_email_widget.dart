import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flexiJobs/features/sign_up/data/models/request/verify_code_request_model.dart';
import 'package:flexiJobs/features/sign_up/presentation/widgets/pin_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyEmailWidget extends StatefulWidget {
  const VerifyEmailWidget({
    super.key,
    required this.forgetPasswordCubit,
    required this.email,
    this.controller,
  });

  final ForgetPasswordCubit forgetPasswordCubit;
  final String email;
  final CountdownTimerController? controller;

  @override
  State<VerifyEmailWidget> createState() => _VerifyEmailWidgetState();
}

class _VerifyEmailWidgetState extends State<VerifyEmailWidget> {
  late CountdownTimerController _localController;
  String? _pinCode;
  bool _enableVerifyButton = false;

  @override
  void initState() {
    super.initState();
    _localController = CountdownTimerController(
      endTime: DateTime.now().millisecondsSinceEpoch +
          const Duration(minutes: 2).inMilliseconds,
      onEnd: () => setState(() {}),
    )..start();
  }

  @override
  void dispose() {
    _localController.disposeTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            text: context.tr(AppLocalizationKeys.enterTheFiveDigitCode),
          ),
        ),
        Center(
          child: AppText(
            style: AppTextStyle.medium_14,
            textAlign: TextAlign.center,
            textColor: Palette.grey_4C4C4C,
            text: _maskEmail(widget.email),
          ),
        ),
        40.heightBox,
        PinFieldWidget(
          forgetPasswordCubit: widget.forgetPasswordCubit,
          email: widget.email,
          controller: widget.controller ?? _localController,
          onPinCodeCompleted: (bool enabled, String pin) {
            if (mounted) {
              setState(() {
                _enableVerifyButton = enabled;
                if (enabled) _pinCode = pin;
              });
            }
          },
        ),
        50.heightBox,
        CustomElevatedButton(
          onPressed: _enableVerifyButton
              ? () {
                  widget.forgetPasswordCubit.verifyCode(
                    verifyCodeRequestModel: VerifyCodeRequestModel(
                      email: widget.email,
                      code: _pinCode!,
                    ),
                  );
                }
              : () {},
          width: 0.9.sw,
          backgroundColor: _enableVerifyButton ? null : Palette.grey_F0F0F0,
          height: 45.h,
          text: context.tr(AppLocalizationKeys.verifyEmailButton),
          textStyle: AppTextStyle.semiBold_16,
        ),
      ],
    );
  }

  String _maskEmail(String email) {
    final List<String> parts = email.split('@');
    if (parts.length != 2) return email;
    final String local = parts[0];
    final String domain = parts[1];
    if (local.length <= 2) return '**@$domain';
    return '${'*' * (local.length - 2)}${local.substring(local.length - 2)}@$domain';
  }
}
