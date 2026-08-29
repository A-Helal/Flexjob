import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/login/data/models/request/login_request_model.dart';
import 'package:flexiJobs/features/shared/GuestCredentials/guest_credentials.dart';
import 'package:flexiJobs/features/login/presentation/cubit/login_cubit.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';

import 'package:flexiJobs/core/constants/app_localization_keys.dart';

class BiometricSection extends StatelessWidget {
  const BiometricSection({
    super.key,
    required this.loginCubit,
    required this.availableBiometrics,
  });

  final LoginCubit loginCubit;
  final List<BiometricType> availableBiometrics;

  Future<void> _handleBiometric(BuildContext context) async {
    final bool? isLoginBefore = LocalData.getFirstLoginInfo();
    if (isLoginBefore == null) {
      ViewsToolbox.showWarningAwesomeSnackBar(
        context,
        context.tr(AppLocalizationKeys.pleaseLoginAtLeastOnce),
      );
      return;
    }

    final String? email = await LocalData.getSecuredEmail();

    if (email == null || email == GuestCredentials.email) {
      ViewsToolbox.showWarningAwesomeSnackBar(
        context,
        context.tr(AppLocalizationKeys.pleaseLoginAtLeastOnce),
      );
      return;
    }

    final bool isAuth = await ViewsToolbox.auth();
    if (!isAuth) return;

    final String? password = await LocalData.getSecuredPassword();
    if (password != null) {
      loginCubit.login(
        loginRequestModel: LoginRequestModel(email: email, password: password),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isFace = availableBiometrics.contains(BiometricType.face);
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            const Expanded(child: Divider(color: Palette.primaryColor)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: AppText(
                text: context.tr(AppLocalizationKeys.orLoginWith),
                style: AppTextStyle.regular_13,
                textColor: Palette.grey_A5A5A5,
              ),
            ),
            const Expanded(child: Divider(color: Palette.primaryColor)),
          ],
        ),
        16.heightBox,
        Center(
          child: _BiometricButton(
            isFace: isFace,
            onTap: () => _handleBiometric(context),
          ),
        ),
      ],
    );
  }
}

class _BiometricButton extends StatefulWidget {
  const _BiometricButton({required this.isFace, required this.onTap});

  final bool isFace;
  final VoidCallback onTap;

  @override
  State<_BiometricButton> createState() => _BiometricButtonState();
}

class _BiometricButtonState extends State<_BiometricButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pressController;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 0.08,
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pressController.forward(),
      onTapUp: (_) {
        _pressController.reverse();
        widget.onTap();
      },
      onTapCancel: () => _pressController.reverse(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFF7F8FA),
            border: Border.all(color: const Color(0xFFE8E8F0), width: 1.5),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Palette.primaryColor.withValues(alpha: 0.12),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: SvgPicture.asset(
              widget.isFace
                  ? 'assets/svg/faceId.svg'
                  : 'assets/svg/fingerPrint.svg',
              width: 26.w,
              height: 26.w,
              colorFilter: ColorFilter.mode(
                Palette.primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
