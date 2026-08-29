import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/app_data/presentation/enum/app_status.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/features/job_details/constants/job_details_constants.dart';
import 'package:flexiJobs/features/job_details/presentation/screens/job_details_screen.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/master_widget.dart';
import 'package:flexiJobs/features/shared/widgets/no_data_widget.dart';
import 'package:flexiJobs/features/shifts/presentation/cubit/shift_cubit.dart';
import 'package:flexiJobs/features/shifts/presentation/widgets/shift_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum JobDate { upcoming, applied, past }

@RoutePage()
class ShiftsScreen extends StatefulWidget {
  const ShiftsScreen({
    super.key,
  });

  @override
  State<ShiftsScreen> createState() => _ShiftsScreenState();
}

class _ShiftsScreenState extends State<ShiftsScreen> {
  final ShiftsCubit _shiftsCubit = getIt<ShiftsCubit>();
  JobDate jobDate = JobDate.applied;
  final ScrollController _scrollController = ScrollController();
  List<JobEntity> _jobs = <JobEntity>[];
  int total = 5;
  int pageNumber = 1;
  @override
  void initState() {
    super.initState();

    if (LocalData.user != null && LocalData.user!.status != null) {
      if (AppStatusHelper.of(LocalData.user!.status) == AppStatus.approved) {
        ViewsToolbox.showLoading();

        if (JobDetailsConstants.jobDate == JobDate.upcoming) {
          _shiftsCubit.getUpcomingJobs();
          jobDate = JobDate.upcoming;
        } else {
          _shiftsCubit.getAppliedJobs();
        }
      } else if (AppStatusHelper.of(LocalData.user!.status) == AppStatus.pending) {
        _shiftsCubit.profileUnderReview();
      }
    }
    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;
      final bool isAtEnd = _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 40.h;
      if (isAtEnd && _jobs.length < total) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocProvider<ShiftsCubit>.value(
        value: _shiftsCubit,
        child: MasterWidget(
            scaffoldColor: Palette.grey_FAFAFA,
            appBar: AppBar(
              backgroundColor: Palette.transparntColor,
              centerTitle: false,
              leadingWidth: 1.sw,
              leading: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: AppText(
                  text: context.tr(AppLocalizationKeys.myShifts),
                  textColor: Palette.secondary,
                  style: AppTextStyle.bold_22,
                ),
              ),
            ),
            widget: BlocConsumer<ShiftsCubit, ShiftState>(
              listener: (BuildContext context, ShiftState state) {
                if (state is ShiftReadyState) {
                  if (state.inProgress) {
                    ViewsToolbox.showLoading();
                  } else {
                    ViewsToolbox.dismissLoading();
                  }
                  _jobs = state.jobs;
                  total = state.total;
                  setState(() {});
                } else if (state is ProfileUnderReviewState) {
                  ViewsToolbox.showWarningAwesomeSnackBar(
                      context, context.tr(AppLocalizationKeys.yourProfileUnderReview));
                } else if (state is ShiftErrorState) {
                  ViewsToolbox.dismissLoading();
                  ViewsToolbox.showErrorAwesomeSnackBar(context, state.message);
                }
              },
              builder: (BuildContext context, ShiftState state) {
                if (state is ProfileUnderReviewState) {
                  return NoDataWidget();
                } else if (state is ShiftReadyState) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Tag(
                              text: context.tr(AppLocalizationKeys.appliedJobs),
                              onTap: () {
                                setState(() {
                                  jobDate = JobDate.applied;
                                  pageNumber = 1;
                                });
                                ViewsToolbox.showLoading();
                                _shiftsCubit.getAppliedJobs();
                              },
                              isSelected: jobDate == JobDate.applied,
                            ),
                            20.widthBox,
                            Tag(
                              text: context.tr(AppLocalizationKeys.upComingJobs),
                              onTap: () {
                                setState(() {
                                  jobDate = JobDate.upcoming;
                                  pageNumber = 1;
                                });
                                ViewsToolbox.showLoading();
                                _shiftsCubit.getUpcomingJobs();
                              },
                              isSelected: jobDate == JobDate.upcoming,
                            ),
                            20.widthBox,
                            Tag(
                              text: context.tr(AppLocalizationKeys.pastJobs),
                              onTap: () {
                                setState(() {
                                  jobDate = JobDate.past;
                                  pageNumber = 1;
                                });
                                ViewsToolbox.showLoading();
                                _shiftsCubit.getPastJobs();
                              },
                              isSelected: jobDate == JobDate.past,
                            ),
                          ],
                        ),
                      ),
                      state.jobs.isEmpty ? Container() : 20.heightBox,
                      state.jobs.isEmpty || LocalData.user != null && LocalData.user!.status == null
                          ? NoDataWidget()
                          : SizedBox(
                              height: 0.68.sh,
                              width: 1.sw,
                              child: ListView.builder(
                                controller: _scrollController,
                                itemBuilder: (BuildContext context, int index) {
                                  return ShiftCardWidget(
                                      jobEntity: state.jobs[index],
                                      jobComingShiftEntity: state.jobComingShiftEntity,
                                      showUpcomingShiftCard:
                                          jobDate == JobDate.upcoming && state.jobComingShiftEntity?.jobId != -1,
                                      jobDetailsRouteFrom: jobDate == JobDate.applied
                                          ? JobDetailsRouteFrom.applied
                                          : jobDate == JobDate.upcoming
                                              ? JobDetailsRouteFrom.upcoming
                                              : JobDetailsRouteFrom.past);
                                },
                                itemCount: state.jobs.length,
                              ),
                            )
                    ],
                  );
                } else if (state is ShiftErrorState) {
                  return NoDataWidget();
                } else if (LocalData.user != null && LocalData.user!.status == null) return NoDataWidget();

                return LocalData.user != null && AppStatusHelper.of(LocalData.user!.status) == AppStatus.approved
                    ? Container()
                    : NoDataWidget();
              },
            )),
      ),
    );
  }

  void _loadMore() {
    setState(() {
      pageNumber = pageNumber + 1;
    });
    _shiftsCubit.loadMoreJobs(pageNumber: pageNumber, jobDate: jobDate);
  }
}

class Tag extends StatelessWidget {
  const Tag({
    super.key,
    required this.text,
    this.onTap,
    this.isSelected = true,
  });

  final void Function()? onTap;
  final bool isSelected;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isSelected ? () {} : onTap,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 30.w,
            ),
            decoration: BoxDecoration(
                color: isSelected ? Palette.secondary : Palette.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.r),
                ),
                border: Border.all(color: Palette.grey_EBEBEB)),
            child: Center(
              child: AppText(
                text: text,
                textColor: isSelected ? Palette.white : Palette.grey_A5A5A5,
                style: AppTextStyle.medium_14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
