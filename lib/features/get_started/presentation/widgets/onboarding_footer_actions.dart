import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/features/get_started/presentation/widgets/guest_login_button.dart';
import 'package:flexiJobs/features/get_started/presentation/widgets/login_row.dart';
import 'package:flexiJobs/features/get_started/presentation/widgets/sign_up_button.dart';
import 'package:flexiJobs/features/login/presentation/cubit/login_cubit.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flutter/material.dart';

class OnboardingFooterActions extends StatelessWidget {
  const OnboardingFooterActions({super.key, required this.loginCubit});

  final LoginCubit loginCubit;

  Future<void> _markCompleted() => LocalData.setHasCompletedOnboarding(true);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GuestLoginButton(
          loginCubit: loginCubit,
          onCompleted: _markCompleted,
        ),
        20.heightBox,
        SignUpButton(onCompleted: _markCompleted),
        30.heightBox,
        LoginRow(onCompleted: _markCompleted),
        24.heightBox,
      ],
    );
  }
}
