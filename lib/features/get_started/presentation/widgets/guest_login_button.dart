import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/features/login/data/models/request/login_request_model.dart';
import 'package:flexiJobs/features/login/presentation/cubit/login_cubit.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestLoginButton extends StatelessWidget {
  const GuestLoginButton({
    super.key,
    required this.loginCubit,
    required this.onCompleted,
  });

  final LoginCubit loginCubit;

  final Future<void> Function() onCompleted;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () async {
        await onCompleted();
        loginCubit.login(
          loginRequestModel: LoginRequestModel(
            email: "guest@flexijobapp.com",
            password: "flexijobapp@2024",
          ),
        );
      },
      width: 0.9.sw,
      height: 45.h,
      text: context.tr(AppLocalizationKeys.exploreJobsAsGuest),
      textStyle: AppTextStyle.semiBold_16,
    );
  }
}
