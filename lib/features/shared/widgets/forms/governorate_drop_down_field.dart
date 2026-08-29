import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/app_data/domain/entities/governorate_entity.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/features/jobs/presentation/widgets/governorate_drop_down_list_bottomsheet.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flexiJobs/core/theming/palette.dart';

class GovernorateDropDownField extends StatefulWidget {
  const GovernorateDropDownField({
    super.key,
    required this.onGovernorate,
    this.initValue,
    required this.controller,
    this.showCloseIcon = false,
  });

  final Function(GovernorateEntity?) onGovernorate;
  final String? initValue;
  final TextEditingController? controller;
  final bool? showCloseIcon;
  @override
  State<GovernorateDropDownField> createState() => _GovernorateDropDownFieldState();
}

class _GovernorateDropDownFieldState extends State<GovernorateDropDownField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: FormBuilderTextField(
          textAlign: TextAlign.start,
          name: "city",
          controller: widget.controller,
          readOnly: true,
          onTap: widget.initValue != null
              ? () {}
              : () => ViewsToolbox.showBottomSheet(
                  context: context,
                  height: 0.9.sh,
                  widget: GovernorateDropDownListBottomSheet(
                    onGovernorate: (GovernorateEntity? governorate) {
                      CustomMainRouter.pop();
                      widget.onGovernorate(governorate);
                    },
                  )),
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
            hintText: context.tr(AppLocalizationKeys.selectGovernorate),
            hintStyle: TextStyle(color: Palette.grey_A5A5A5),
            suffixIcon: widget.showCloseIcon!
                ? GestureDetector(
                    onTap: () => widget.onGovernorate(null),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Icon(
                        Icons.close,
                        size: 25.w,
                      ),
                    ),
                  )
                : null,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: SvgPicture.asset(
                "assets/svg/location-pin.svg",
              ),
            ),
          )),
    );
  }
}
