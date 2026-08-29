import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/forget_password/data/models/request/create_new_password_request_model.dart';
import 'package:flexiJobs/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flexiJobs/features/shared/widgets/forms/password_field_widget.dart';
import 'package:flexiJobs/features/sign_up/presentation/widgets/pwd_validator/custom_password_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CreateNewPasswordFormWidget extends StatefulWidget {
  const CreateNewPasswordFormWidget({
    super.key,
    required this.forgetPasswordCubit,
    required this.token,
  });

  final ForgetPasswordCubit forgetPasswordCubit;
  final String token;

  @override
  State<CreateNewPasswordFormWidget> createState() =>
      _CreateNewPasswordFormWidgetState();
}

class _CreateNewPasswordFormWidgetState
    extends State<CreateNewPasswordFormWidget> {
  final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  bool _formValid = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _strengthValid = false;

  @override
  void dispose() {
    _password.dispose();
    _confirmPassword.dispose();
    _newPasswordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  bool get _canSubmit => _formValid && _strengthValid;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      onChanged: () {
        setState(() {
          _formValid = _key.currentState?.isValid ?? false;
        });
      },
      key: _key,
      child: Column(
        children: <Widget>[
          150.heightBox,
          Center(
            child: AppText(
              text: context.tr(AppLocalizationKeys.createNewPassword),
              style: AppTextStyle.bold_20,
              textColor: Palette.primaryColor,
            ),
          ),
          50.heightBox,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: PasswordFieldWidget(
              obscureText: !_passwordVisible,
              focusNode: _newPasswordFocus,
              controller: _password,
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: _passwordVisible
                      ? Palette.grey_A5A5A5
                      : Palette.purple_8E29DE,
                ),
                onPressed: () {
                  setState(() => _passwordVisible = !_passwordVisible);
                },
              ),
              labelAboveField:
                  context.tr(AppLocalizationKeys.createNewPassword),
              hintStyle: TextStyle(color: Palette.grey_A5A5A5),
              keyName: 'password',
              hintText: context.tr(AppLocalizationKeys.passwordHint),
              validator: FormBuilderValidators.compose(
                <FormFieldValidator<String>>[
                  FormBuilderValidators.required(),
                ],
              ),
            ),
          ),
          20.heightBox,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: PasswordFieldWidget(
              focusNode: _confirmPasswordFocus,
              obscureText: !_confirmPasswordVisible,
              controller: _confirmPassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _confirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: _confirmPasswordVisible
                      ? Palette.grey_A5A5A5
                      : Palette.purple_8E29DE,
                ),
                onPressed: () {
                  setState(
                      () => _confirmPasswordVisible = !_confirmPasswordVisible);
                },
              ),
              labelAboveField: context.tr(AppLocalizationKeys.confirmPassword),
              hintStyle: TextStyle(color: Palette.grey_A5A5A5),
              keyName: 'confirmPassword',
              hintText: context.tr(AppLocalizationKeys.passwordHint),
              validator: FormBuilderValidators.compose(
                <FormFieldValidator<String>>[
                  FormBuilderValidators.required(),
                ],
              ),
            ),
          ),
          20.heightBox,
          CustomFlutterPwValidator(
            controller: _password,
            minLength: 8,
            matches: 1,
            secondcontroller: _confirmPassword,
            uppercaseCharCount: 1,
            lowercaseCharCount: 1,
            numericCharCount: 1,
            specialCharCount: 1,
            width: 400,
            height: 150,
            onSuccess: () => setState(() => _strengthValid = true),
            onFail: () => setState(() => _strengthValid = false),
          ),
          150.heightBox,
          CustomElevatedButton(
            onPressed: _canSubmit
                ? () {
                    widget.forgetPasswordCubit.changePassword(
                      createNewPasswordRequestModel:
                          CreateNewPasswordRequestModel(
                        password: _password.text,
                        // ignore: non_constant_identifier_names
                        confirm_password: _confirmPassword.text,
                        token: widget.token,
                      ),
                    );
                  }
                : () {},
            width: 0.9.sw,
            backgroundColor: _canSubmit ? null : Palette.grey_F0F0F0,
            height: 45.h,
            text: context.tr(AppLocalizationKeys.submit),
            textStyle: AppTextStyle.semiBold_16,
          ),
        ],
      ),
    );
  }
}
