import 'package:flexiJobs/features/login/data/models/request/login_request_model.dart';
import 'package:flexiJobs/features/login/presentation/cubit/login_cubit.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/underline_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/shared/widgets/forms/email_field_widget.dart';
import 'package:flexiJobs/features/shared/widgets/forms/password_field_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:local_auth/local_auth.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({
    super.key,
    required this.loginCubit,
    this.availableBiometrics,
  });

  final LoginCubit loginCubit;
  final List<BiometricType>? availableBiometrics;

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _passwordVisible = false;

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final FormBuilderFields fields = _formKey.currentState!.fields;
    widget.loginCubit.login(
      loginRequestModel: LoginRequestModel(
        email: fields[LoginFormKeys.email]!.value as String,
        password: fields[LoginFormKeys.password]!.value as String,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _EmailField(),
          16.heightBox,
          _PasswordField(
            visible: _passwordVisible,
            onToggle: () => setState(() => _passwordVisible = !_passwordVisible),
          ),
          12.heightBox,
          _ForgotPasswordLink(),
          24.heightBox,
          _SubmitButton(onPressed: _submit),
        ],
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EmailFieldWidget(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.email(),
      ]),
      labelAboveField: context.tr(AppLocalizationKeys.email),
      keyName: LoginFormKeys.email,
      prefixIcon: Icon(Icons.email_outlined,color: Palette.grey_2C2C2C,),
      hintStyle: TextStyle(color: Palette.grey_A5A5A5),
      hintText: context.tr(AppLocalizationKeys.emailHint),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({required this.visible, required this.onToggle});

  final bool visible;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return PasswordFieldWidget(
      obscureText: !visible,
      suffixIcon: IconButton(
        icon: Icon(
          visible ? Icons.visibility_rounded : Icons.visibility_off_rounded,
          color: visible ? Palette.grey_A5A5A5 : Palette.primaryColor,
          size: 20.sp,
        ),
        onPressed: onToggle,
      ),
      labelAboveField: context.tr(AppLocalizationKeys.password),
      hintStyle: TextStyle(color: Palette.grey_A5A5A5,),
      keyName: LoginFormKeys.password,
      prefixIcon: Icon(Icons.lock_outline,color: Palette.grey_2C2C2C,),
      hintText: context.tr(AppLocalizationKeys.passwordHint),
      validator: FormBuilderValidators.compose(<FormFieldValidator<String>>[
        FormBuilderValidators.required(),
      ]),
    );
  }
}

class _ForgotPasswordLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: UnderlineTextWidget(
        text: context.tr(AppLocalizationKeys.forgetPassword),
        onTap: () => CustomMainRouter.push(ForgetPasswordRoute()),
      ),
    );
  }
}

class _SubmitButton extends StatefulWidget {
  const _SubmitButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pressCtrl;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _pressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _pressCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pressCtrl.forward(),
      onTapUp: (_) {
        _pressCtrl.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _pressCtrl.reverse(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          height: 52.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            gradient: LinearGradient(
              colors: [
                Palette.primaryColor,
                Palette.primaryColor.withValues(alpha: 0.80),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Palette.primaryColor.withValues(alpha: 0.35),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: AppText(
              text: context.tr(AppLocalizationKeys.loginButton),
              style: AppTextStyle.semiBold_16,
              textColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
class LoginFormKeys {
  static String email = "email";
  static String password = "password";
}
