import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flexiJobs/core/theming/palette.dart';

class GovernorateSearchField extends StatefulWidget {
  const GovernorateSearchField({super.key, this.onChanged});
  final void Function(String?)? onChanged;
  @override
  State<GovernorateSearchField> createState() => _GovernorateSearchFieldState();
}

class _GovernorateSearchFieldState extends State<GovernorateSearchField> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
        onChanged: widget.onChanged,
        textAlign: TextAlign.start,
        name: "city",
        controller: _controller,
        // initialValue: _controller.text.isNotEmpty ? _controller.text : null,
        decoration: InputDecoration(
          prefixIconConstraints: BoxConstraints(maxWidth: 50.w),
          enabledBorder: OutlineInputBorder(  
              borderRadius: BorderRadius.circular(40), borderSide: const BorderSide(color: Palette.primaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40), borderSide: const BorderSide(color: Palette.primaryColor)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40), borderSide: const BorderSide(color: Palette.primaryColor)),
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 17.w,
          ),
          hintText: context.tr(AppLocalizationKeys.searchGovernorate),
          hintStyle: TextStyle(color: Palette.grey_A5A5A5),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: SvgPicture.asset(
              "assets/svg/search.svg",
            ),
          ),
        ));
  }
}
