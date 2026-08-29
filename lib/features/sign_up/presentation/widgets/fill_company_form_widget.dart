import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/features/complete_profile/presentation/widgets/phone_field.dart';
import 'package:flexiJobs/features/login/presentation/cubit/login_cubit.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/forms/text_field_widget.dart';
import 'package:flexiJobs/features/sign_up/data/models/request/vendor_requet_model.dart';
import 'package:flexiJobs/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:flexiJobs/features/sign_up/presentation/widgets/guest_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/shared/widgets/forms/email_field_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl_phone_field/phone_number.dart';

class FillCompanyFormWidget extends StatefulWidget {
  const FillCompanyFormWidget({
    super.key,
    required this.signUpCubit,
    required this.loginCubit,
    required this.formKey,
    required this.phoneNumber,
    required this.phoneCode,
    required this.emailController,
    required this.companyController,
    required this.fullNameController,
    required this.positionController,
    this.enableSendEmailButton = false,
  });

  final SignUpCubit signUpCubit;
  final LoginCubit loginCubit;
  final GlobalKey<FormBuilderState> formKey;
  final TextEditingController phoneNumber;
  final TextEditingController phoneCode;
  final TextEditingController emailController;
  final TextEditingController companyController;
  final TextEditingController fullNameController;
  final TextEditingController positionController;
  final bool enableSendEmailButton;

  @override
  State<FillCompanyFormWidget> createState() => _FillCompanyFormWidgetState();
}

class _FillCompanyFormWidgetState extends State<FillCompanyFormWidget> {
  late bool _enableButton;

  final FocusNode _fullNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _companyFocus = FocusNode();
  final FocusNode _positionFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _enableButton = widget.enableSendEmailButton;
  }

  @override
  void dispose() {
    _fullNameFocus.dispose();
    _emailFocus.dispose();
    _companyFocus.dispose();
    _positionFocus.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  bool get _allFilled =>
      widget.phoneNumber.text.isNotEmpty &&
          widget.emailController.text.isNotEmpty &&
          widget.companyController.text.isNotEmpty &&
          widget.fullNameController.text.isNotEmpty &&
          widget.positionController.text.isNotEmpty;

  void _checkEnable() {
    if (_allFilled != _enableButton) {
      setState(() => _enableButton = _allFilled);
    }
  }

  void _submit() {
    if (!_enableButton) return;
    if (!(_formKey?.currentState?.validate() ?? false)) return;
    final FormBuilderFields fields = widget.formKey.currentState!.fields;
    widget.signUpCubit.sendVendorEmail(
      vendorRequestModel: VendorRequestModel(
        email: fields[CompanyFormKeys.email]!.value as String,
        name: fields[CompanyFormKeys.company]!.value as String,
        phoneNumber:
        widget.phoneCode.text.replaceAll('+', '') + widget.phoneNumber.text,
        position: fields[CompanyFormKeys.position]!.value as String,
        fullName: fields[CompanyFormKeys.fullName]!.value as String,
      ),
    );
  }

  GlobalKey<FormBuilderState>? get _formKey => widget.formKey;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget.formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            8.heightBox,
            _CompanyTextField(
              controller: widget.emailController,
              focusNode: _emailFocus,
              keyName: CompanyFormKeys.email,
              label: context.tr(AppLocalizationKeys.emailText),
              hint: context.tr(AppLocalizationKeys.emailHint),
              isEmail: true,
              onChanged: (_) => _checkEnable(),
            ),
            16.heightBox,
            _CompanyTextField(
              controller: widget.fullNameController,
              focusNode: _fullNameFocus,
              keyName: CompanyFormKeys.fullName,
              label: context.tr(AppLocalizationKeys.fullName),
              hint: context.tr(AppLocalizationKeys.fullName),
              onChanged: (_) => _checkEnable(),
            ),
            16.heightBox,
            _CompanyTextField(
              controller: widget.companyController,
              focusNode: _companyFocus,
              keyName: CompanyFormKeys.company,
              label: context.tr(AppLocalizationKeys.companyName),
              hint: context.tr(AppLocalizationKeys.companyName),
              onChanged: (_) => _checkEnable(),
            ),
            16.heightBox,
            _CompanyTextField(
              controller: widget.positionController,
              focusNode: _positionFocus,
              keyName: CompanyFormKeys.position,
              label: context.tr(AppLocalizationKeys.position),
              hint: context.tr(AppLocalizationKeys.position),
              onChanged: (_) => _checkEnable(),
            ),
            16.heightBox,
            _CompanyPhoneField(
              phoneNumber: widget.phoneNumber,
              phoneCode: widget.phoneCode,
              focusNode: _phoneFocus,
              onChanged: (_) => _checkEnable(),
            ),
            24.heightBox,
            _SubmitCompanyButton(
              enabled: _enableButton,
              onPressed: _submit,
            ),
            16.heightBox,
            const GuestTextButton(),
            24.heightBox,
          ],
        ),
      ),
    );
  }
}

class _CompanyTextField extends StatelessWidget {
  const _CompanyTextField({
    required this.controller,
    required this.focusNode,
    required this.keyName,
    required this.label,
    required this.hint,
    this.isEmail = false,
    this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String keyName;
  final String label;
  final String hint;
  final bool isEmail;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    if (isEmail) {
      return EmailFieldWidget(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        validator: FormBuilderValidators.compose(<FormFieldValidator<String>>[
          FormBuilderValidators.required(),
          FormBuilderValidators.email(),
        ]),
        labelAboveField: label,
        keyName: keyName,
        hintStyle: TextStyle(color: Palette.grey_A5A5A5),
        hintText: hint,
      );
    }
    return TextFieldWidget(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onTap: focusNode.requestFocus,
      keyName: keyName,
      labelAboveField: label,
      hintText: hint,
      validator: FormBuilderValidators.compose(<FormFieldValidator<String>>[
        FormBuilderValidators.required(),
      ]),
    );
  }
}

class _CompanyPhoneField extends StatelessWidget {
  const _CompanyPhoneField({
    required this.phoneNumber,
    required this.phoneCode,
    required this.focusNode,
    required this.onChanged,
  });

  final TextEditingController phoneNumber;
  final TextEditingController phoneCode;
  final FocusNode focusNode;
  final ValueChanged<PhoneNumber> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppText(
          text: context.tr(AppLocalizationKeys.phoneNumberText),
          textColor: Palette.primaryColor,
          style: AppTextStyle.semiBold_14,
        ),
        8.heightBox,
        PhoneField(
          initialValue: phoneNumber.text,
          focusNode: focusNode,
          onTap: focusNode.requestFocus,
          keyName: CompanyFormKeys.phone,
          onChanged: (PhoneNumber phone) {
            phoneNumber.text = phone.number;
            phoneCode.text = phone.countryCode;
            onChanged(phone);
          },
        ),
      ],
    );
  }
}

class _SubmitCompanyButton extends StatelessWidget {
  const _SubmitCompanyButton({
    required this.enabled,
    required this.onPressed,
  });

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
              text: context.tr(AppLocalizationKeys.submit),
              style: AppTextStyle.semiBold_16,
              textColor: enabled ? Colors.white : const Color(0xFFAAAAAA),
            ),
          ),
        ),
      ),
    );
  }
}

class CompanyFormKeys {
  static const String fullName = 'fullName';
  static const String email = 'email';
  static const String company = 'company';
  static const String position = 'position';
  static const String phone = 'phone';
}