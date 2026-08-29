import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flexiJobs/features/shared/widgets/forms/email_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EnterEmailFormWidget extends StatefulWidget {
  const EnterEmailFormWidget({
    super.key,
    required this.forgetPasswordCubit,
  });

  final ForgetPasswordCubit forgetPasswordCubit;

  @override
  State<EnterEmailFormWidget> createState() => _EnterEmailFormWidgetState();
}

class _EnterEmailFormWidgetState extends State<EnterEmailFormWidget> {
  final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();
  bool _enableSendButton = false;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: () {
        setState(() {
          _enableSendButton = _key.currentState?.isValid ?? false;
        });
      },
      key: _key,
      child: Column(
        children: <Widget>[
          150.heightBox,
          Center(
            child: AppText(
              text: context.tr(AppLocalizationKeys.passwordReset),
              style: AppTextStyle.bold_20,
              textColor: Palette.primaryColor,
            ),
          ),
          20.heightBox,
          Center(
            child: SizedBox(
              width: 0.7.sw,
              child: AppText(
                textAlign: TextAlign.center,
                text: context.tr(
                    AppLocalizationKeys.enterTheEmailAssociatedWithYourAccount),
                style: AppTextStyle.medium_13,
                textColor: Palette.grey_4C4C4C,
              ),
            ),
          ),
          30.heightBox,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: EmailFieldWidget(
              validator: FormBuilderValidators.compose(
                  <FormFieldValidator<String>>[
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
              labelAboveField: context.tr(AppLocalizationKeys.email),
              keyName: 'email',
              hintStyle: TextStyle(color: Palette.grey_A5A5A5),
              hintText: context.tr(AppLocalizationKeys.emailHint),
            ),
          ),
          300.heightBox,
          CustomElevatedButton(
            onPressed: _enableSendButton
                ? () {
                    final String? email =
                        _key.currentState?.fields['email']?.value as String?;
                    if (email != null) {
                      widget.forgetPasswordCubit.resendCode(email: email);
                    }
                  }
                : () {},
            width: 0.9.sw,
            backgroundColor: _enableSendButton ? null : Palette.grey_F0F0F0,
            height: 45.h,
            text: context.tr(AppLocalizationKeys.sendEmail),
            textStyle: AppTextStyle.semiBold_16,
          ),
        ],
      ),
    );
  }
}
