// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/helpers/date_time_helper.dart';
import 'package:flexiJobs/core/helpers/job_date_helper.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class JobDetailsCardWidget extends StatelessWidget {
  const JobDetailsCardWidget({super.key, required this.jobEntity});
  final JobEntity jobEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 190.h),
        child: Container(
          width: 0.9.sw,
          decoration: BoxDecoration(
              color: Palette.jobBoxShadow.withOpacity(.20),
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              border: GradientBoxBorder(
                gradient: LinearGradient(colors: <Color>[Palette.secondary, Palette.blue_9747FF]),
              )),
          child: job_details(
            jobEntity: jobEntity,
          ),
        ),
      ),
    );
  }
}

class job_details extends StatelessWidget {
  const job_details({super.key, required this.jobEntity});
  final JobEntity jobEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        20.heightBox,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: <Widget>[
              AppText(
                text: jobEntity.title,
                style: AppTextStyle.bold_13,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),

              //   text: "( ${jobEntity.shiftHours} ${context.tr(AppLocalizationKeys.hoursShift)})",
              //   textColor: Palette.grey_4C4C4C,
              //   style: AppTextStyle.bold_12,
              // ),
              5.heightBox,
              AppText(
                text: jobEntity.totalPrice.toString() + " " + context.tr(AppLocalizationKeys.egp),
                textColor: Palette.secondary,
                style: AppTextStyle.bold_22,
              ),
              10.heightBox,
              PricePerHour(
                price: jobEntity.vendorPayPricePerHour.toString(),
                shiftHour: jobEntity.shiftHours.toString(),
              ),
              12.heightBox,
              IconWithText(
                pathIcon: "assets/svg/time_icon.svg",
                text: DateTimeHelper.formatTime(jobEntity.startTime) +
                    " " +
                    context.tr(AppLocalizationKeys.to) +
                    " " +
                    DateTimeHelper.formatTime(jobEntity.endTime),
              ),
              12.heightBox,
              IconWithText(
                pathIcon: "assets/svg/job_calendar_icon.svg",
                text: _getDateText(
                    context,
                    DateTimeHelper.formatTime(jobEntity.startTime),
                    DateTimeHelper.formatTime(jobEntity.endTime),
                    jobEntity.startDate,
                    jobEntity.endDate),
                iconWidth: 14.w,
              ),
              12.heightBox,
              IconWithText(
                iconWidth: 14.w,
                pathIcon: "assets/svg/job_calendar_icon.svg",
                text:
                    "${JobDateHelper.checkDateAndDays(start: DateTimeHelper.formatTime(jobEntity.startTime), end: DateTimeHelper.formatTime(jobEntity.endTime), startDate: jobEntity.startDate, dateTimeEndDate: jobEntity.endDate).days} ${context.tr(AppLocalizationKeys.days)}",
              ),
              12.heightBox,
            ],
          ),
        ),
      ],
    );
  }

  String _getDateText(BuildContext context, String start, String end, DateTime startDate, DateTime endDate) {
    if (JobDateHelper.checkDateAndDays(start: start, end: end, startDate: startDate, dateTimeEndDate: endDate).days! >
        1) {
      return DateTimeHelper.formatDate(jobEntity.startDate.toIso8601String()) +
          " " +
          context.tr(AppLocalizationKeys.to) +
          " " +
          DateTimeHelper.formatDate(jobEntity.endDate.toIso8601String());
    } else {
      return DateTimeHelper.formatDate(jobEntity.startDate.toIso8601String());
    }
  }
}

class PricePerHour extends StatelessWidget {
  const PricePerHour({
    Key? key,
    required this.price,
    required this.shiftHour,
  }) : super(key: key);
  final String price;
  final String shiftHour;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4.w,
      children: <Widget>[
        AppText(
          text: price + " " + context.tr(AppLocalizationKeys.perHour),
          textColor: const Color.fromARGB(255, 76, 76, 76),
          style: AppTextStyle.medium_12,
        ),
        AppText(
          text: "(${shiftHour} ${context.tr(AppLocalizationKeys.hoursShift)})",
          textColor: Palette.grey_4C4C4C,
          style: AppTextStyle.bold_12,
        ),
      ],
    );
  }
}

class IconWithText extends StatelessWidget {
  const IconWithText({super.key, required this.text, required this.pathIcon, this.iconWidth});
  final String text;
  final String pathIcon;
  final double? iconWidth;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            pathIcon,
            width: iconWidth ?? 15.w,
          ),
          8.widthBox,
          Expanded(
            child: AppText(
              text: text,
              textColor: Palette.grey_4C4C4C,
              style: AppTextStyle.medium_12,
              maxLines: 2,
            ),
          ),
          4.widthBox,
        ],
      ),
    );
  }
}
