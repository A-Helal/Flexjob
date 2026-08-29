import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/app_validator.dart';
import 'package:flexiJobs/core/helpers/language_helper.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/complete_profile/presentation/widgets/custom_intel_phone_field.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneField extends StatefulWidget {
  const PhoneField({
    Key? key,
    required this.onChanged,
    required this.keyName,
    this.initialValue,
    this.phoneCode,
    this.onTap,
    this.disabled = false,
    this.focusNode,
  }) : super(key: key);
  final void Function(PhoneNumber)? onChanged;
  final String keyName;
  final String? initialValue;
  final String? phoneCode;
  final bool? disabled;
  final FocusNode? focusNode;
  final Function()? onTap;
  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  @override
  Widget build(BuildContext context) {
    return CustomIntlPhoneField(
        enabled: !widget.disabled!,
        focusNode: widget.focusNode,
        invalidNumberMessage: context.tr("invalidPhoneNumber"),
        //  autovalidateMode: AutovalidateMode.onUnfocus,
        onTapToChanegCountry: widget.onTap,
        languageCode: context.locale.languageCode,
        validator: (PhoneNumber? value) => AppValidator.validatorRequired(value, context),
        decoration: InputDecoration(
            border: const OutlineInputBorder(
          borderSide: BorderSide(),
        )),
        initialValue: widget.initialValue,
        disableLengthCheck: false,
        dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.r))),
        pickerDialogStyle: PickerDialogStyle(
          searchFieldInputDecoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 17.w,
              ),
              hintText: context.tr("search"),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: SvgPicture.asset(
                  "assets/svg/search.svg",
                ),
              )),
        ),
        initialCountryCode: widget.phoneCode ?? 'EG',
        onChanged: widget.onChanged);
  }
}
