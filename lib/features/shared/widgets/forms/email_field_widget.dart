import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flexiJobs/core/theming/palette.dart';
import '../app_text.dart';

class EmailFieldWidget extends StatelessWidget {
  const EmailFieldWidget({
    super.key,
    required this.keyName,
    this.validator,
    this.hintText,
    this.hintStyle,
    this.suffixIcon,
    this.prefixIcon,
    this.contentPadding,
    this.focusNode,
    this.labelAboveField,
    this.controller,
    this.onChanged
  });
  final String keyName;
  final String? labelAboveField;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppText(
          text: labelAboveField,
          textColor: Palette.primaryColor,
          style: AppTextStyle.semiBold_16,
        ),
        Padding(
          padding: labelAboveField != null
              ? EdgeInsets.only(top: 10.h)
              : EdgeInsets.zero,
          child: FormBuilderTextField(
            controller: controller,
            focusNode: focusNode,
            name: keyName,
            onChanged:onChanged ,
            validator: validator,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: contentPadding ??
                    EdgeInsets.symmetric(
                      vertical: 17.h,
                      horizontal: 17.w,
                    ),
                hintText: hintText,
                hintStyle: hintStyle,
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
