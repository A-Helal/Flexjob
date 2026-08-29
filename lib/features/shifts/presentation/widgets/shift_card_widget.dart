// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/helpers/date_time_helper.dart';
import 'package:flexiJobs/core/helpers/job_date_helper.dart';
import 'package:flexiJobs/features/job_details/presentation/screens/job_details_screen.dart';
import 'package:flexiJobs/features/jobs/domain/entities/upcoming_shift_entity.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';

class ShiftCardWidget extends StatelessWidget {
  const ShiftCardWidget({
    super.key,
    required this.jobDetailsRouteFrom,
    required this.jobEntity,
    this.jobComingShiftEntity,
    this.showUpcomingShiftCard = false,
  });

  final JobDetailsRouteFrom jobDetailsRouteFrom;
  final JobEntity jobEntity;
  final bool showUpcomingShiftCard;
  final UpcomingShiftEntity? jobComingShiftEntity;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          CustomMainRouter.push(JobDetailsRoute(jobDetailsRouteFrom: jobDetailsRouteFrom, jobId: jobEntity.id)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 230.h),
          child: Card(
            color: Palette.white,
            shape: OutlineInputBorder(
              borderSide: BorderSide(color: Palette.purple_8E29DE),
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
            ),
            elevation: 0.2,
            child: job_details(
              jobComingShiftEntity: jobComingShiftEntity,
              showUpcomingShiftCard: showUpcomingShiftCard,
              jobEntity: jobEntity,
            ),
          ),
        ),
      ),
    );
  }
}

class job_details extends StatelessWidget {
  const job_details({
    super.key,
    required this.jobEntity,
    this.showUpcomingShiftCard = false,
    this.jobComingShiftEntity,
  });
  final JobEntity jobEntity;
  final bool showUpcomingShiftCard;
  final UpcomingShiftEntity? jobComingShiftEntity;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            20.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: AppText(
                          text: jobEntity.title,
                          style: AppTextStyle.bold_18,
                          maxLines: 2,
                        ),
                      ),
                      8.widthBox,
                      AppText(
                        text: jobEntity.totalPrice.toString() + " " + context.tr(AppLocalizationKeys.egp),
                        textColor: Palette.grey_4C4C4C,
                        style: AppTextStyle.bold_15,
                        maxLines: 1,
                      ),
                    ],
                  ),
                  3.heightBox,
                  AppText(
                    text: "(${jobEntity.shiftHours} ${context.tr(AppLocalizationKeys.hoursShift)})",
                    textColor: Palette.grey_A5A5A5,
                    style: AppTextStyle.semiBold_12,
                  ),
                  20.heightBox,

                  IconWithText(
                    pathIcon: "assets/svg/time_icon.svg",
                    text:
                        DateTimeHelper.formatTime(jobEntity.startTime) +
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
                      jobEntity.endDate,
                    ),
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
                  IconWithText(iconWidth: 14.w, pathIcon: "assets/svg/branch.svg", text: jobEntity.vendorBranch ?? ""),
                  12.heightBox,
                ],
              ),
            ),
          ],
        ),
        if (showUpcomingShiftCard && jobComingShiftEntity != null && jobComingShiftEntity?.jobId == jobEntity.id)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 1.sw,
              child: Center(
                child: AppText(
                  style: AppTextStyle.semiBold_15,
                  textColor: Palette.white,
                  text: context.tr(
                    AppLocalizationKeys.yourShift,
                    args: <String>[
                      DateTimeHelper.formatTimeString(
                        (jobComingShiftEntity?.actualCheckIn ?? DateTime.now()).toIso8601String(),
                      ),
                    ],
                  ),
                ),
              ),
              height: 50.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[Palette.secondary, Palette.blue_9747FF]),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                  bottomLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                ),
              ),
            ),
          ),
      ],
    );
  }

  String _getDateText(BuildContext context, String start, String end, DateTime startDate, DateTime endDate) {
    if (JobDateHelper.checkDateAndDays(start: start, end: end, startDate: startDate, dateTimeEndDate: endDate).days! >
        1) {
      return DateTimeHelper.formatDate(startDate.toIso8601String()) +
          " " +
          context.tr(AppLocalizationKeys.to) +
          " " +
          DateTimeHelper.formatDate(endDate.toIso8601String());
    } else {
      return DateTimeHelper.formatDate(startDate.toIso8601String());
    }
  }
}

class PricePerHour extends StatelessWidget {
  const PricePerHour({Key? key, required this.price, required this.shiftHour}) : super(key: key);
  final String price;
  final String shiftHour;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        AppText(
          text: price + " " + context.tr(AppLocalizationKeys.perHour),
          textColor: const Color.fromARGB(255, 76, 76, 76),
          style: AppTextStyle.medium_12,
        ),
        4.widthBox,
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
    return Row(
      children: <Widget>[
        SvgPicture.asset(pathIcon, width: iconWidth ?? 15.w),
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
    );
  }
}
