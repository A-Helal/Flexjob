import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/login/data/models/request/login_request_model.dart';
import 'package:flexiJobs/features/login/presentation/cubit/login_cubit.dart';
import 'package:flexiJobs/features/shared/GuestCredentials/guest_credentials.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';

class GuestTextButton extends StatelessWidget {
  const GuestTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppText(
          text: context.tr(AppLocalizationKeys.exploreJobsAs),
          style: AppTextStyle.regular_14,
          textColor: Palette.grey_757575,
        ),
        4.widthBox,
        GestureDetector(
          onTap: () {
            context.read<LoginCubit>().login(
              loginRequestModel: LoginRequestModel(
                email: GuestCredentials.email,
                password: GuestCredentials.password,
                isGuest: true,
              ),
            );
          },
          child: AppText(
            text: context.tr(AppLocalizationKeys.guest),
            style: AppTextStyle.semiBold_14,
            textColor: Palette.purple_8E29DE,
          ),
        ),
      ],
    );
  }
}
