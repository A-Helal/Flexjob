import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/features/login/presentation/cubit/login_cubit.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/underline_text_widget.dart';
import 'package:flexiJobs/features/sign_up/data/models/request/sign_up_request_model.dart';
import 'package:flexiJobs/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:flexiJobs/features/sign_up/presentation/widgets/guest_text_button.dart';
import 'package:flexiJobs/features/sign_up/presentation/widgets/pwd_validator/custom_password_validator.dart';
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

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({
    super.key,
    required this.signUpCubit,
    required this.loginCubit,
  });

  final SignUpCubit signUpCubit;
  final LoginCubit loginCubit;

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _enableCreateAccount = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_enableCreateAccount) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;
    widget.signUpCubit.signUp(
      signUpRequestModel: SignUpRequestModel(
        email:
            _formKey.currentState!.fields[SignUpFormKeys.email]!.value
                as String,
        password:
            _formKey.currentState!.fields[SignUpFormKeys.password]!.value
                as String,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            8.heightBox,
            _SignUpEmailField(),
            16.heightBox,
            _SignUpPasswordField(
              controller: _passwordController,
              visible: _passwordVisible,
              onToggle: () =>
                  setState(() => _passwordVisible = !_passwordVisible),
            ),
            12.heightBox,
            CustomFlutterPwValidator(
              controller: _passwordController,
              minLength: 8,
              uppercaseCharCount: 1,
              lowercaseCharCount: 1,
              numericCharCount: 1,
              specialCharCount: 1,
              width: 400,
              height: 150,
              onSuccess: () => setState(() => _enableCreateAccount = true),
              onFail: () => setState(() => _enableCreateAccount = false),
            ),
            8.heightBox,
            const _TermsAndPrivacy(),
            20.heightBox,
            _CreateAccountButton(
              enabled: _enableCreateAccount,
              onPressed: _submit,
            ),
            20.heightBox,
            const _AlreadyHaveAccountRow(),
            10.heightBox,
            const GuestTextButton(),
            24.heightBox,
          ],
        ),
      ),
    );
  }
}

class _SignUpEmailField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EmailFieldWidget(
      validator: FormBuilderValidators.compose(<FormFieldValidator<String>>[
        FormBuilderValidators.required(),
        FormBuilderValidators.email(),
      ]),
      labelAboveField: context.tr(AppLocalizationKeys.emailText),
      keyName: SignUpFormKeys.email,
      prefixIcon: Icon(Icons.email_outlined, color: Palette.grey_2C2C2C),
      hintStyle: TextStyle(color: Palette.grey_A5A5A5),
      hintText: context.tr(AppLocalizationKeys.emailHint),
    );
  }
}

class _SignUpPasswordField extends StatelessWidget {
  const _SignUpPasswordField({
    required this.controller,
    required this.visible,
    required this.onToggle,
  });

  final TextEditingController controller;
  final bool visible;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return PasswordFieldWidget(
      obscureText: !visible,
      controller: controller,
      suffixIcon: IconButton(
        icon: Icon(
          visible ? Icons.visibility_rounded : Icons.visibility_off_rounded,
          color: visible ? Palette.grey_A5A5A5 : Palette.primaryColor,
          size: 20.sp,
        ),
        onPressed: onToggle,
      ),
      labelAboveField: context.tr(AppLocalizationKeys.password),
      hintStyle: TextStyle(color: Palette.grey_A5A5A5),
      prefixIcon: Icon(Icons.lock_outline, color: Palette.grey_2C2C2C),
      keyName: SignUpFormKeys.password,
      hintText: context.tr(AppLocalizationKeys.passwordHint),
      validator: FormBuilderValidators.compose(<FormFieldValidator<String>>[
        FormBuilderValidators.required(),
      ]),
    );
  }
}

class _TermsAndPrivacy extends StatelessWidget {
  const _TermsAndPrivacy();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppText(
          text: context.tr(AppLocalizationKeys.byAccepting),
          style: AppTextStyle.medium_13,
          textAlign: TextAlign.center,
          textColor: Palette.grey_757575,
        ),
        8.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            UnderlineTextWidget(
              style: AppTextStyle.semiBold_14,
              text: context.tr(AppLocalizationKeys.termsAndConditions),
              onTap: () => ViewsToolbox.launchUrlHelper(
                'https://flexijobapp.com/terms-and-conditions',
              ),
            ),
            5.widthBox,
            AppText(
              text: context.tr(AppLocalizationKeys.and),
              style: AppTextStyle.regular_13,
              textAlign: TextAlign.center,
            ),
            5.widthBox,
            UnderlineTextWidget(
              style: AppTextStyle.semiBold_14,
              text: context.tr(AppLocalizationKeys.privacyPolicy),
              onTap: () => ViewsToolbox.launchUrlHelper(
                'https://flexijobapp.com/privacy-policy',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CreateAccountButton extends StatelessWidget {
  const _CreateAccountButton({required this.enabled, required this.onPressed});

  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 52.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: enabled
            ? LinearGradient(
                colors: <Color>[
                  Palette.primaryColor,
                  Palette.primaryColor.withValues(alpha: 0.80),
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              )
            : null,
        color: enabled ? null : const Color(0xFFEEEEEE),
        boxShadow: enabled
            ? <BoxShadow>[
                BoxShadow(
                  color: Palette.primaryColor.withValues(alpha: 0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: enabled ? onPressed : null,
          child: Center(
            child: AppText(
              text: context.tr(AppLocalizationKeys.createAccount),
              style: AppTextStyle.semiBold_16,
              textColor: enabled ? Palette.white : const Color(0xFFAAAAAA),
            ),
          ),
        ),
      ),
    );
  }
}

class _AlreadyHaveAccountRow extends StatelessWidget {
  const _AlreadyHaveAccountRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppText(
          text: context.tr(AppLocalizationKeys.alreadyHaveAnAccount),
          style: AppTextStyle.regular_14,
          textColor: Palette.grey_757575,
        ),
        4.widthBox,
        GestureDetector(
          onTap: () => CustomMainRouter.push(LoginRoute()),
          child: AppText(
            text: context.tr(AppLocalizationKeys.login),
            style: AppTextStyle.semiBold_14,
            textColor: Palette.purple_8E29DE,
          ),
        ),
      ],
    );
  }
}

class SignUpFormKeys {
  static const String email = 'email';
  static const String password = 'password';
}
