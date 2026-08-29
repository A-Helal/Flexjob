import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/app_data/presentation/cubit/user/user_cubit.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/features/notification/domain/entities/notification_entity.dart';
import 'package:flexiJobs/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flexiJobs/features/shared/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class IntroductionVideoScreen extends StatefulWidget {
  const IntroductionVideoScreen({super.key, this.isSumbitted = false});

  final bool isSumbitted;
  @override
  State<IntroductionVideoScreen> createState() =>
      _IntroductionVideoScreenState();
}

class _IntroductionVideoScreenState extends State<IntroductionVideoScreen> {
  GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();
  String? serviceName;
  NotificationCubit _notificationCubit = getIt<NotificationCubit>();
  UserCubit _userCubit = getIt<UserCubit>();
  String? data;
  bool isSubmmited = false;
  ScrollController _scrollController = ScrollController();
  CountdownTimerController? controller;
  List<NotificationEntity>? notifications = <NotificationEntity>[];
  bool hasMore = false;
  @override
  void initState() {
    super.initState();
    // Refresh user info to check video status when screen loads
    if (LocalData.user != null) {
      _userCubit.getUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: MasterWidget(
        hasScroll: true,
        scaffoldColor: Palette.grey_FAFAFA,
        appBar: ViewsToolbox.showAppBar(
          title: context.tr(AppLocalizationKeys.introVideo),
        ),
        widget:
            LocalData.user?.introVideoStatus != null &&
                    LocalData.user!.introVideoStatus == "pending" ||
                LocalData.user?.introVideoStatus == "rejected" ||
                LocalData.user?.introVideoStatus == "approved"
            ? AfterSubmitted(status: LocalData.user?.introVideoStatus ?? "") //
            : BeforeSubmitted(
                onSumbitted: () {
                  setState(() {
                    isSubmmited = true;
                  });
                },
              ),
      ),
    );
  }
}


class BeforeSubmitted extends StatelessWidget {
  const BeforeSubmitted({super.key, this.onSumbitted});

  final Function? onSumbitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          10.heightBox,
          Center(child: SvgPicture.asset('assets/svg/introVideo.svg')),
          Center(
            child: AppText(
              text: context.tr(AppLocalizationKeys.introduce),
              textColor: Palette.primaryColor,
              style: AppTextStyle.semiBold_19,
              textAlign: TextAlign.center,
            ),
          ),
          10.heightBox,
          Center(
            child: AppText(
              text: context.tr(AppLocalizationKeys.requireVideo),
              textColor: Palette.grey_2C2C2C,
              style: AppTextStyle.regular_15,
              textAlign: TextAlign.center,
            ),
          ),
          10.heightBox,
          Center(
            child: AppText(
              text: context.tr(AppLocalizationKeys.increaseShift),
              textColor: Palette.grey_2C2C2C,
              style: AppTextStyle.regular_15,
              textAlign: TextAlign.center,
            ),
          ),
          50.heightBox,
          AppText(
            text: context.tr(AppLocalizationKeys.tips),
            textColor: Palette.primaryColor,
            style: AppTextStyle.semiBold_15,
          ),
          10.heightBox,
          AppText(
            text: context.tr(AppLocalizationKeys.tipsName),
            textColor: Palette.grey_2C2C2C,
            style: AppTextStyle.regular_15,
          ),
          10.heightBox,
          AppText(
            text: context.tr(AppLocalizationKeys.tipsSkills),
            textColor: Palette.grey_2C2C2C,
            style: AppTextStyle.regular_15,
          ),
          10.heightBox,
          AppText(
            text: context.tr(AppLocalizationKeys.tipsExperience),
            textColor: Palette.grey_2C2C2C,
            style: AppTextStyle.regular_15,
          ),
          10.heightBox,
          AppText(
            text: context.tr(AppLocalizationKeys.tipsLang),
            textColor: Palette.grey_2C2C2C,
            style: AppTextStyle.regular_15,
          ),
          10.heightBox,
          AppText(
            text: context.tr(AppLocalizationKeys.tipsHobby),
            textColor: Palette.grey_2C2C2C,
            style: AppTextStyle.regular_15,
          ),
          50.heightBox,
          CustomElevatedButton(
            height: 50.h,
            width: 0.9.sw,
            onPressed: () {
              CustomMainRouter.push(
                VideoRecordRoute(),
                then: (Object? value) {
                  if (value != null && value == true) {
                    onSumbitted?.call();
                  }
                },
              );
            },
            text: context.tr(AppLocalizationKeys.start),
          ),
        ],
      ),
    );
  }
}

class AfterSubmitted extends StatelessWidget {
  const AfterSubmitted({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    String titleText = "";
    String bodyText = "";
    String? extraBodyText;

    if (status == "pending") {
      titleText = context.tr(AppLocalizationKeys.videoHasBeenSubmitted);
      bodyText = context.tr(AppLocalizationKeys.onceVideo);
    } else if (status == "approved") {
      titleText = context.tr(AppLocalizationKeys.videoHasBeenApproved);
      bodyText = context.tr(AppLocalizationKeys.youCanNowApplyToAnyShift);
    } else if (status == "rejected") {
      titleText = context.tr(AppLocalizationKeys.videoHasBeenRejected);
      bodyText = context.tr(AppLocalizationKeys.youCanTryAgainLater);
    }

    return Column(
      children: <Widget>[
        150.heightBox,
        SvgPicture.asset('assets/svg/introVideo.svg'),
        10.heightBox,
        AppText(
          text: titleText,
          textColor: Palette.primaryColor,
          textAlign: TextAlign.center,
          style: AppTextStyle.bold_19,
        ),
        10.heightBox,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: AppText(
            textAlign: TextAlign.center,
            text: bodyText,
            textColor: Palette.black,
            style: AppTextStyle.regular_12,
          ),
        ),
        if (extraBodyText != null) ...[
          6.heightBox,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: AppText(
              textAlign: TextAlign.center,
              text: extraBodyText!,
              textColor: Palette.black,
              style: AppTextStyle.regular_12,
            ),
          ),
        ],
        180.heightBox,
        CustomElevatedButton(
          height: 50.h,
          width: 0.9.sw,
          onPressed: () {
            CustomMainRouter.push(
              NavigationMainRoute(children: <PageRouteInfo>[JobsRoute()]),
            );
          },
          text: context.tr(AppLocalizationKeys.goHome),
        ),
      ],
    );
  }
}
