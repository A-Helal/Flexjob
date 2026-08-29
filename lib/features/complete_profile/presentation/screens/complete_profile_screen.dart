import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flexiJobs/core/app_data/presentation/cubit/user/user_cubit.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/language_helper.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/complete_profile/helper/parse_status.dart';
import 'package:flexiJobs/features/complete_profile/presentation/cubit/complete_profile_cubit.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  CompleteProfileCubit _completeProfileCubit = getIt<CompleteProfileCubit>();
  @override
  void initState() {
    _completeProfileCubit.getUniversites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CompleteProfileCubit>.value(
        value: _completeProfileCubit,
        child: BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
          builder: (BuildContext context, CompleteProfileState state) {
            return MasterWidget(
                scaffoldColor: Palette.grey_FAFAFA,
                appBar: ViewsToolbox.showAppBar(
                  title: context.tr(AppLocalizationKeys.completeProfileTitle),
                ),
                widget: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ParentStepper(),
                      Column(
                        children: <Widget>[
                          StepCard(
                            title: context.tr(AppLocalizationKeys.personalInformation),
                            desc: context.tr(AppLocalizationKeys.fillInSomePersonalInformation),
                            enabled: true,
                            onTap: () => CustomMainRouter.push(
                              PersonalInformationRoute(
                                completeProfileCubit: _completeProfileCubit,
                                 viewMode: false),
                              
                            ),
                          ),
                          StepCard(
                            enabled: ParseStatusHelper.step() >= 2,
                            title: context.tr(AppLocalizationKeys.documentsUpload),
                            desc: context.tr(AppLocalizationKeys.verifyIdentity),
                            onTap: () => CustomMainRouter.push(
                                UploadDocumentsRoute(completeProfileCubit: _completeProfileCubit, viewMode: false)),
                          ),
                          StepCard(
                            enabled: ParseStatusHelper.step() >= 3,
                            title: context.tr(AppLocalizationKeys.paymentInformation),
                            desc: context.tr(AppLocalizationKeys.determineTheBestWayWage),
                            onTap: () => CustomMainRouter.push(
                                PaymentMethodRoute(completeProfileCubit: _completeProfileCubit, viewMode: false)),
                          ),
                          StepCard(
                            enabled: ParseStatusHelper.step() >= 4,
                            title: context.tr(AppLocalizationKeys.skillsAndExperience),
                            desc: context.tr(AppLocalizationKeys.knowYourSkills),
                            onTap: () => CustomMainRouter.push(
                                SkillsExperienceRoute(completeProfileCubit: _completeProfileCubit, viewMode: false)),
                          ),
                          StepCard(
                            enabled: ParseStatusHelper.step() >= 5,
                            title: context.tr(AppLocalizationKeys.agreementSigning),
                            desc: context.tr(AppLocalizationKeys.signTheAgreement),
                            onTap: () => CustomMainRouter.push(
                                AgreementsSigningRoutes(completeProfileCubit: _completeProfileCubit, viewMode: false)),
                          ),
                        ],
                      )
                    ],
                  ),
                ));
          },
        ));
  }
}

class ParentStepper extends StatelessWidget {
  const ParentStepper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
        alignment: LanguageHelper.isAr(context) ? Alignment.topRight : Alignment.topLeft,
        padding: EdgeInsets.zero,
        activeStep: ParseStatusHelper.step() - 1,
        showTitle: false,
        // lineStyle: LineStyle(defaultLineColor: Colors.transparent),
        internalPadding: 0,
        lineStyle: LineStyle(
          lineType: LineType.normal,
          lineThickness: 3.w,
          activeLineColor: Palette.purple_8E29DE,
          finishedLineColor: Palette.purple_8E29DE,
          unreachedLineColor: Palette.grey_A5A5A5,
          lineLength: 70.h,
        ),
        showLoadingAnimation: false,
        stepRadius: 20.r,
        direction: Axis.vertical,
        showStepBorder: false,
        //    lineDotRadius: 1.5,
        steps: <EasyStep>[
          EasyStep(
            customLineWidget: Container(
              width: 100,
              height: 100,
              color: Palette.black,
            ),
            customStep: StepWidget(
              number: "1",
              isDone: true,
            ),
          ),
          EasyStep(
            customLineWidget: Container(),
            customStep: StepWidget(
              number: "2",
              isDone: ParseStatusHelper.step() >= 2,
            ),
          ),
          EasyStep(
            customLineWidget: Container(),
            customStep: StepWidget(
              number: "3",
              isDone: ParseStatusHelper.step() >= 3,
            ),
          ),
          EasyStep(
            customLineWidget: Container(),
            customStep: StepWidget(
              number: "4",
              isDone: ParseStatusHelper.step() >= 4,
            ),
          ),
          EasyStep(
            customLineWidget: Container(),
            customStep: StepWidget(
              number: "5",
              isDone: ParseStatusHelper.step() >= 5,
            ),
          ),
        ],
        onStepReached: (int index) {});
  }
}

class StepCard extends StatelessWidget {
  const StepCard({super.key, this.enabled = true, required this.onTap, required this.title, required this.desc});

  final bool enabled;
  final Function() onTap;
  final String title;
  final String desc;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : () {},
      child: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(minHeight: 90.h),
              // width: 330.w,
              // height: 90.h,
              child: Card(
                elevation: 1,
                shape: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                ),
                color: enabled ? Palette.grey_F0F0F0 : Palette.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          4.heightBox,
                          AppText(
                            text: context.tr(
                              title,
                            ),
                            style: AppTextStyle.medium_17,
                            textColor: enabled ? Palette.secondary : Palette.grey_4C4C4C,
                          ),
                          4.heightBox,
                          SizedBox(
                            width: 300.w,
                            child: AppText(
                              text: context.tr(
                                desc,
                              ),
                              style: AppTextStyle.medium_14,
                              textColor: enabled ? Palette.black : Palette.grey_A5A5A5,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class StepWidget extends StatelessWidget {
  const StepWidget({super.key, required this.number, this.isDone = false});
  final String number;
  final bool isDone;
  @override
  Widget build(BuildContext context) {
    return isDone
        ? Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: Palette.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Palette.purple_8E29DE,
                width: 2.w,
              ),
            ),
            child: Center(
              child: Container(
                  width: 28.w,
                  height: 28.w,
                  decoration: BoxDecoration(
                    color: Palette.primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Palette.purple_8E29DE,
                      width: 2.w,
                    ),
                  ),
                  child: Center(
                    child: AppText(
                      text: number,
                      textColor: Palette.white,
                      style: AppTextStyle.semiBold_15,
                    ),
                  )),
            ),
          )
        : Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: Palette.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Palette.grey_A5A5A5,
                width: 2.w,
              ),
            ),
            child: Center(
              child: AppText(
                text: number,
                textColor: Palette.grey_A5A5A5,
                style: AppTextStyle.semiBold_15,
              ),
            ));
  }
}
