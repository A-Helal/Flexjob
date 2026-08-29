import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/features/forget_password/data/models/request/create_new_password_request_model.dart';
import 'package:flexiJobs/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/master_widget.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flexiJobs/features/shared/widgets/forms/password_field_widget.dart';
import 'package:flexiJobs/features/sign_up/presentation/widgets/pwd_validator/custom_password_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

@RoutePage()
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();
  final ForgetPasswordCubit _forgetPasswordCubit = getIt<ForgetPasswordCubit>();

  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _oldPassword = TextEditingController();

  final FocusNode _oldPasswordFocus = FocusNode();
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _oldPasswordVisible = false;
  bool _strengthValid = false;

  @override
  void dispose() {
    _password.dispose();
    _confirmPassword.dispose();
    _oldPassword.dispose();
    _oldPasswordFocus.dispose();
    _newPasswordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _key,
      child: MasterWidget(
        scaffoldColor: Palette.grey_FAFAFA,
        appBar: ViewsToolbox.showAppBar(
          title: context.tr(AppLocalizationKeys.changePassword),
        ),
        widget: BlocProvider<ForgetPasswordCubit>.value(
          value: _forgetPasswordCubit,
          child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
            listener: (BuildContext context, ForgetPasswordState state) {
              if (state is ForgetPasswordReadyState) {
                if (state.errorMessage != null) {
                  ViewsToolbox.dismissLoading();
                  ViewsToolbox.showErrorAwesomeSnackBar(
                      context, state.errorMessage!);
                } else if (state.inProgress!) {
                  ViewsToolbox.showLoading();
                } else if (state.passwordChanged!) {
                  ViewsToolbox.dismissLoading();
                  CustomMainRouter.pop();
                  ViewsToolbox.showSuccessAwesomeSnackBar(
                      context,
                      context
                          .tr(AppLocalizationKeys.successChangePassword));
                }
              }
            },
            builder: (BuildContext context, ForgetPasswordState state) {
              return Column(
                children: <Widget>[
                  150.heightBox,
                  Center(
                    child: AppText(
                      text: context.tr(AppLocalizationKeys.changePassword),
                      style: AppTextStyle.bold_20,
                      textColor: Palette.primaryColor,
                    ),
                  ),
                  50.heightBox,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: PasswordFieldWidget(
                      focusNode: _oldPasswordFocus,
                      obscureText: !_oldPasswordVisible,
                      controller: _oldPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _oldPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: _oldPasswordVisible
                              ? Palette.grey_A5A5A5
                              : Palette.purple_8E29DE,
                        ),
                        onPressed: () => setState(
                            () => _oldPasswordVisible = !_oldPasswordVisible),
                      ),
                      labelAboveField:
                          context.tr(AppLocalizationKeys.oldPassword),
                      hintStyle: TextStyle(color: Palette.grey_A5A5A5),
                      keyName: 'oldPassword',
                      hintText: context.tr(AppLocalizationKeys.oldPassword),
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
                      focusNode: _newPasswordFocus,
                      obscureText: !_passwordVisible,
                      controller: _password,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: _passwordVisible
                              ? Palette.grey_A5A5A5
                              : Palette.purple_8E29DE,
                        ),
                        onPressed: () => setState(
                            () => _passwordVisible = !_passwordVisible),
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
                        onPressed: () => setState(() =>
                            _confirmPasswordVisible = !_confirmPasswordVisible),
                      ),
                      labelAboveField:
                          context.tr(AppLocalizationKeys.confirmPassword),
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
                  70.heightBox,
                  CustomElevatedButton(
                    onPressed: _strengthValid
                        ? () {
                            if (_key.currentState!.saveAndValidate()) {
                              _forgetPasswordCubit.changePassword(
                                createNewPasswordRequestModel:
                                    CreateNewPasswordRequestModel(
                                  old_password: _oldPassword.text,
                                  confirm_password: _confirmPassword.text,
                                  password: _password.text,
                                ),
                              );
                            }
                          }
                        : () {},
                    width: 0.9.sw,
                    backgroundColor:
                        _strengthValid ? null : Palette.grey_F0F0F0,
                    height: 45.h,
                    text: context.tr(AppLocalizationKeys.submit),
                    textStyle: AppTextStyle.semiBold_16,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
