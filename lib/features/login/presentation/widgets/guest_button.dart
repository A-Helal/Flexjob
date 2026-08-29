import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/login/data/models/request/login_request_model.dart';
import 'package:flexiJobs/features/login/presentation/cubit/login_cubit.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestButton extends StatelessWidget {
  const GuestButton();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          context.read<LoginCubit>().login(
            loginRequestModel: LoginRequestModel(
              email: "guest@flexijobapp.com",
              password: "flexijobapp@2024",
            ),
          );
        },
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF8A8A9A),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppText(
              text: context.tr(AppLocalizationKeys.company),
              style: AppTextStyle.regular_15,
              textColor: Palette.grey_757575,
            ),
            6.widthBox,
            GestureDetector(
              onTap: () => CustomMainRouter.push(SignUpRoute()),
              child: AppText(
                text: context.tr(AppLocalizationKeys.signUp),
                style: AppTextStyle.semiBold_14,
                textColor: Palette.purple_8E29DE,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
