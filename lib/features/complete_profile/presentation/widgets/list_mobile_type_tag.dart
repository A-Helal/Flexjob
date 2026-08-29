import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/core/routing/routes.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/forms/image_uploader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListOfMobileServicesType extends StatefulWidget {
  const ListOfMobileServicesType({super.key, required this.onChanged, this.currentService, this.disabled = false});

  final Function(String) onChanged;
  final String? currentService;
  final bool? disabled;
  @override
  State<ListOfMobileServicesType> createState() => _ListOfMobileServicesTypeState();
}

class _ListOfMobileServicesTypeState extends State<ListOfMobileServicesType> {
  List<String> servicesNames = <String>["Vodafone", "Etisalat", "Orange"];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: servicesNames
            .map((String service) => GestureDetector(
                  onTap: widget.disabled!
                      ? () {}
                      : () {
                          widget.onChanged(service.toLowerCase());
                        },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                        decoration: BoxDecoration(
                            color: widget.currentService == service.toLowerCase() ? Palette.primaryColor : null,
                            border: Border.all(color: Palette.grey_EBEBEB),
                            borderRadius: BorderRadius.all(Radius.circular(20.r))),
                        child: AppText(
                          text: service,
                          textColor:
                              widget.currentService == service.toLowerCase() ? Palette.white : Palette.black_373737,
                          style: AppTextStyle.medium_14,
                        )),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
