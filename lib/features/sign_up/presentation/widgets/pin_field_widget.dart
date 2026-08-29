import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/underline_text_widget.dart';
import 'package:flexiJobs/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:flexiJobs/features/sign_up/presentation/widgets/custom_counter_down_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'dart:ui' as ui;

class PinFieldWidget extends StatefulWidget {
  const PinFieldWidget(
      {super.key,
      required this.onPinCodeCompleted,
      required this.controller,
      required this.email,
      this.signUpCubit,
      this.forgetPasswordCubit});
  final Function(bool, String) onPinCodeCompleted;
  final CountdownTimerController? controller;
  final SignUpCubit? signUpCubit;
  final ForgetPasswordCubit? forgetPasswordCubit;
  final String email;
  @override
  State<PinFieldWidget> createState() => _PinFieldWidgetState();
}

class _PinFieldWidgetState extends State<PinFieldWidget> {
  TextEditingController _pinController = TextEditingController();
  String seconds = "";

  final PinTheme defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Palette.grey_A5A5A5),
      borderRadius: BorderRadius.circular(8.r),
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Pinput(
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: defaultPinTheme,
          submittedPinTheme: defaultPinTheme,
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          showCursor: true,
          controller: _pinController,
          onChanged: (String value) {
            if (_pinController.text.length < 4) {
              widget.onPinCodeCompleted(false, _pinController.text);
            } else {
              widget.onPinCodeCompleted(true, _pinController.text);
            }
          },
          onCompleted: (String pin) {
            widget.onPinCodeCompleted(true, pin);
          },
        ),
        30.heightBox,
        Directionality(
          textDirection: ui.TextDirection.ltr,
          child: CustomCounterDownWidget(
            key: ValueKey(widget.controller),
            widgetBuilder: (_, CurrentRemainingTime? time) {
              return time == null
                  ? Container()
                  : AppText(
                      textColor: Palette.purpleNavyColor,
                      style: AppTextStyle.semiBold_16,
                      text:
                          "    ${time.min == null ? "00" : time.min.toString().padLeft(2, '0')} : ${time.sec.toString().padLeft(2, '0')} ");
            },
            controller: widget.controller,
            onEnd: () {
              widget.controller!.disposeTimer();
            },
            endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 10,
          ),
        ),
        30.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppText(
              text: context.tr(
                AppLocalizationKeys.doNotReceivedCode,
              ),
              textColor: Palette.grey_4A5051,
              style: AppTextStyle.medium_15,
              textAlign: TextAlign.center,
            ),
            5.widthBox,
            UnderlineTextWidget(
              textColor: widget.controller!.isRunning ? Palette.grey_4C4C4C : null,
              text: context.tr(
                AppLocalizationKeys.resend,
              ),
              onTap: widget.controller!.isRunning
                  ? () {}
                  : () {
                      widget.signUpCubit != null
                          ? widget.signUpCubit!.resendCode(email: widget.email)
                          : widget.forgetPasswordCubit!.resendCode(email: widget.email, fromVerify: true);
                    },
            )
          ],
        ),
      ],
    );
  }
}
