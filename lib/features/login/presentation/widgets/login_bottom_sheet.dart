import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/features/login/presentation/cubit/login_cubit.dart';
import 'package:flexiJobs/features/login/presentation/widgets/biometric_section.dart';
import 'package:flexiJobs/features/login/presentation/widgets/guest_button.dart';
import 'package:flexiJobs/features/login/presentation/widgets/login_form_widget.dart';
import 'package:flexiJobs/features/login/presentation/widgets/login_header.dart';
import 'package:flexiJobs/features/login/presentation/widgets/sign_up_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';

class LoginBottomSheet extends StatelessWidget {
  const LoginBottomSheet({
    super.key,
    required this.loginCubit,
    required this.availableBiometrics,
  });

  final LoginCubit loginCubit;
  final List<BiometricType> availableBiometrics;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,

      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const LoginHeader(),
            24.heightBox,
            LoginFormWidget(
              loginCubit: loginCubit,
              availableBiometrics: availableBiometrics,
            ),
            32.heightBox,
            if (availableBiometrics.isNotEmpty) ...<Widget>[
              BiometricSection(
                loginCubit: loginCubit,
                availableBiometrics: availableBiometrics,
              ),
              24.heightBox,
            ],
            const SignUpRow(),
            8.heightBox,
            const GuestButton(),
          ],
        ),
      ),
    );
  }
}