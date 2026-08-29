import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flexiJobs/core/helpers/language_helper.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/theming/theme.dart';
import '../app_text.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key,
      required this.keyName,
      this.validator,
      this.hintText,
      this.hintStyle,
      this.suffixIcon,
      this.contentPadding,
      this.labelAboveField,
      this.maxLines,
      this.prefixIcon,
      this.initalValue,
      this.controller,
      this.readOnly = false,
      this.align,
      this.textDirection,
      this.onTap,
      this.disabled = false,
      this.textStyle,
      this.focusNode,
      this.onChanged,
      this.keyboardType,
      this.maxLength,
      this.inputFormatters});
  final String keyName;
  final String? labelAboveField;
  final String? hintText;
  final String? initalValue;
  final String? Function(String?)? validator;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLines;
  final TextEditingController? controller;
  final bool readOnly;
  final bool disabled;
  final TextAlign? align;
  final TextDirection? textDirection;
  final int? maxLength;
  final Function()? onTap;
  final TextStyle? textStyle;
  final void Function(String?)? onChanged;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (labelAboveField != null)
          AppText(
            text: labelAboveField,
            textColor: AppTheme.inDarkMode(context, dark: Palette.white, light: Palette.primaryColor),
            style: AppTextStyle.semiBold_16,
          ),
        Padding(
          padding: labelAboveField != null ? EdgeInsets.only(top: 10.h) : EdgeInsets.zero,
          child: FormBuilderTextField(
            onTap: onTap,
            textAlign: align ?? TextAlign.start,
            textDirection: textDirection ?? (LanguageHelper.isAr(context) ? TextDirection.rtl : TextDirection.ltr),
            readOnly: readOnly,
            enabled: !disabled,
            maxLines: maxLines ?? 1,
            name: keyName,
            onChanged: onChanged,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: textStyle ?? TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400, color: Colors.black),
            maxLength: maxLength,
            controller: controller,
            validator: validator,
            focusNode: focusNode,
            keyboardType: keyboardType,
            initialValue: initalValue,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: contentPadding ??
                    EdgeInsets.symmetric(
                      vertical: 18.h,
                      horizontal: 17.w,
                    ),
                hintText: hintText,
                hintStyle: hintStyle,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon),
          ),
        ),
      ],
    );
  }
}
