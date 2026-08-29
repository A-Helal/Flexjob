import 'package:auto_route/auto_route.dart';
import 'package:flexiJobs/core/app_data/domain/entities/job_category_entity.dart';
import 'package:flexiJobs/core/app_data/presentation/cubit/user/user_cubit.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/complete_profile/presentation/cubit/complete_profile_cubit.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flexiJobs/features/shared/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class SkillsExperienceScreen extends StatefulWidget {
  const SkillsExperienceScreen({super.key, required this.completeProfileCubit, this.viewMode = false});
  final CompleteProfileCubit completeProfileCubit;
  final bool viewMode;

  @override
  State<SkillsExperienceScreen> createState() => _SkillsExperienceScreenState();
}

class _SkillsExperienceScreenState extends State<SkillsExperienceScreen> {
  List<JobCategoryEntity> jobCategories = <JobCategoryEntity>[];
  List<int> jobCategoriesIds = <int>[];
  @override
  void initState() {
    if (LocalData.user!.jobCategories!.isNotEmpty) {
      jobCategoriesIds = LocalData.user!.jobCategories!.map((JobCategoryEntity job) => job.id!).toList();
    }
    WidgetsBinding.instance.addPostFrameCallback((Duration Duration) async {
      jobCategories = await LocalData.getJobCateGories();

      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompleteProfileCubit, CompleteProfileState>(
        bloc: widget.completeProfileCubit,
        listener: (BuildContext context, CompleteProfileState state) {
          if (state is CompleteProfileLoadingState) {
            ViewsToolbox.showLoading();
          } else if (state is CompleteProfileReadyState) {
            ViewsToolbox.dismissLoading();
            ViewsToolbox.showSuccessAwesomeSnackBar(context, context.tr(AppLocalizationKeys.skillsAddedSuccessfully));

            CustomMainRouter.pop();
          }
          if (state is CompleteProfileErrorState) {
            ViewsToolbox.dismissLoading();
            ViewsToolbox.showErrorAwesomeSnackBar(context, state.message);
          }
        },
        child: MasterWidget(
            scaffoldColor: Palette.grey_FAFAFA,
            appBar: ViewsToolbox.showAppBar(
              title: context.tr(AppLocalizationKeys.skillsAndExperience),
            ),
            widget: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                AppText(
                  text: context.tr(AppLocalizationKeys.iHaveExperienceAt),
                  style: AppTextStyle.bold_17,
                  textColor: Palette.primaryColor,
                ),
                20.heightBox,
                Wrap(
                  direction: Axis.horizontal,
                  children: jobCategories
                      .map((JobCategoryEntity entity) => GestureDetector(
                            onTap: () {
                              if (jobCategoriesIds.contains(entity.id)) {
                                jobCategoriesIds.remove(entity.id);
                              } else {
                                jobCategoriesIds.add(entity.id!);
                              }
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: jobCategoriesIds.contains(entity.id!) ? Palette.primaryColor : Palette.white,
                                    border: Border.all(color: Palette.grey_EBEBEB),
                                    borderRadius: BorderRadius.all(Radius.circular(10.r))),
                                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                                child: AppText(
                                  text: entity.name,
                                  style: AppTextStyle.medium_15,
                                  textColor: jobCategoriesIds.contains(entity.id!) ? Palette.white : Palette.black,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
                50.heightBox,
                CustomElevatedButton(
                  onPressed: jobCategoriesIds.isNotEmpty
                      ? () {
                          widget.completeProfileCubit.completeSkills(jobCategoriesIds: jobCategoriesIds);
                        }
                      : () {},
                  width: 0.9.sw,
                  backgroundColor: jobCategoriesIds.isNotEmpty ? Palette.primaryColor : Palette.grey_F0F0F0,
                  height: 45.h,
                  text: context.tr(AppLocalizationKeys.submit),
                  textStyle: AppTextStyle.semiBold_16,
                )
              ]),
            )));
  }
}
