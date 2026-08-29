import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/app_data/presentation/enum/app_status.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/helpers/date_time_helper.dart';
import 'package:flexiJobs/core/helpers/job_date_helper.dart';
import 'package:flexiJobs/core/helpers/use_helper.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/complete_profile/presentation/cubit/complete_profile_cubit.dart';
import 'package:flexiJobs/features/complete_profile/presentation/widgets/confirm_to_update_profile.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/features/job_details/constants/job_details_constants.dart';
import 'package:flexiJobs/features/job_details/presentation/cubit/job_details_cubit.dart';
import 'package:flexiJobs/features/job_details/presentation/enum/job_state_type.dart';
import 'package:flexiJobs/features/job_details/presentation/widgets/how_get_job_widget.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/features/jobs/domain/entities/vendor_entity.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flexiJobs/features/shared/widgets/underline_text_widget.dart';
import 'package:flexiJobs/features/shifts/presentation/screens/shifts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

enum JobDetailsRouteFrom { pendingHome, home, upcoming, past, applied, jobList }

@RoutePage()
class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({
    super.key,
    required this.jobDetailsRouteFrom,
    required this.jobId,
  });

  final JobDetailsRouteFrom jobDetailsRouteFrom;
  final int jobId;

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  final JobDetailsCubit _jobDetailsCubit = getIt<JobDetailsCubit>();
  final CompleteProfileCubit _completeProfileCubit =
      getIt<CompleteProfileCubit>();

  @override
  void initState() {
    super.initState();
    _jobDetailsCubit.getJobById(id: widget.jobId);
    // Loading is handled by the BlocConsumer listener reacting to
    // JobDetailsLoadingState — do NOT call showLoading() here
    // as the cubit may already have emitted synchronously.
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<JobDetailsCubit>.value(
      value: _jobDetailsCubit,
      child: DefaultTabController(
        length: 2,
        child: BlocConsumer<JobDetailsCubit, JobDetailsState>(
          listener: _onState,
          builder: _buildScaffold,
        ),
      ),
    );
  }

  Widget _buildScaffold(BuildContext context, JobDetailsState state) {
    if (state is! JobDetailsReadyState) {
      return Scaffold(
        backgroundColor: Palette.grey_FAFAFA,
        appBar: _simpleAppBar(context, null),
      );
    }

    final JobEntity job = state.appJobEntity.jobs!;
    final DateTime currentTime = state.appJobEntity.current_datetime != null
        ? DateTime.parse(state.appJobEntity.current_datetime!)
        : DateTime.now();

    return Scaffold(
      backgroundColor: Palette.grey_FAFAFA,
      appBar: _simpleAppBar(context, job.jobCategory),
      body: Column(
        children: <Widget>[
          _JobHeader(job: job),
          _buildTabBar(context),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                _DescriptionTab(job: job),
                _CompanyTab(job: job),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(context, state, job, currentTime),
    );
  }

  AppBar _simpleAppBar(BuildContext context, String? title) {
    return AppBar(
      backgroundColor: Palette.secondary,
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => CustomMainRouter.pop(),
        child: Icon(
          Icons.arrow_back_ios_rounded,
          color: Palette.white,
          size: 20.r,
        ),
      ),
      title: title != null
          ? AppText(
              text: title,
              textColor: Palette.white,
              style: AppTextStyle.bold_16,
            )
          : null,
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      color: Palette.white,
      child: TabBar(
        labelColor: Palette.secondary,
        unselectedLabelColor: Palette.grey_A5A5A5,
        indicatorColor: Palette.secondary,
        indicatorWeight: 3,
        labelStyle: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Cairo',
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          fontFamily: 'Cairo',
        ),
        tabs: <Tab>[
          Tab(text: context.tr(AppLocalizationKeys.descriptionTab)),
          Tab(text: context.tr(AppLocalizationKeys.companyTab)),
        ],
      ),
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    JobDetailsReadyState state,
    JobEntity job,
    DateTime currentTime,
  ) {
    return Container(
      color: Palette.white,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 12.h),
          child: _buttonDisplay(
            currentTime: currentTime,
            jobDetailsRouteFrom: widget.jobDetailsRouteFrom,
            jobDetailsCubit: _jobDetailsCubit,
            jobEntity: job,
            jobId: job.id,
          ),
        ),
      ),
    );
  }

  void _onState(BuildContext context, JobDetailsState state) {
    if (state is JobDetailsLoadingState) {
      ViewsToolbox.showLoading();
    } else if (state is JobDetailsReadyState) {
      if (state.isNeedVideo) {
        ViewsToolbox.dismissLoading();
        CustomMainRouter.push(IntroductionVideoRoute());
        ViewsToolbox.showWarningAwesomeSnackBar(context, context.tr('needVideo'));
      }
      if (state.inProgress) {
        ViewsToolbox.showLoading();
      } else {
        ViewsToolbox.dismissLoading();
      }
      if (state.message != null) {
        ViewsToolbox.dismissLoading();
        ViewsToolbox.showErrorAwesomeSnackBar(context, state.message!);
      }
      if (state.jobStateType != null) {
        JobDetailsConstants.jobDate = JobDate.upcoming;
        ViewsToolbox.showSuccessAwesomeSnackBar(
          context,
          JobStateTypeHelper.getText(state.jobStateType!),
        );
        if (state.jobStateType == JobStateType.checkedIn ||
            state.jobStateType == JobStateType.checkedout) {
          CustomMainRouter.push(
            NavigationMainRoute(children: <PageRouteInfo>[ShiftsRoute()]),
          );
        } else {
          JobDetailsConstants.jobDate = JobDate.applied;
          CustomMainRouter.push(
            NavigationMainRoute(children: <PageRouteInfo>[ShiftsRoute()]),
          );
        }
      }
    } else if (state is JobDetailsErrorState) {
      ViewsToolbox.dismissLoading();
      ViewsToolbox.showErrorAwesomeSnackBar(context, state.message);
    }
  }

  Widget _buttonDisplay({
    required DateTime currentTime,
    required JobDetailsRouteFrom jobDetailsRouteFrom,
    required JobDetailsCubit jobDetailsCubit,
    required JobEntity jobEntity,
    required int jobId,
  }) {
    if (LocalData.user != null && UseHelper.isGuest()) {
      return Center(
        child: CustomElevatedButton(
          onPressed: () => CustomMainRouter.push(SignUpRoute()),
          width: 0.9.sw,
          height: 48.h,
          text: context.tr(AppLocalizationKeys.createAccountGuest),
          textStyle: AppTextStyle.semiBold_16,
        ),
      );
    } else if (LocalData.user != null && LocalData.user!.status == null) {
      return Center(
        child: CustomElevatedButton(
          onPressed: () => CustomMainRouter.push(CompleteProfileRoute()),
          width: 0.9.sw,
          height: 48.h,
          text: context.tr(AppLocalizationKeys.completeYourProfileToApply),
          textStyle: AppTextStyle.semiBold_16,
        ),
      );
    } else if (LocalData.user != null &&
        (AppStatusHelper.of(LocalData.user!.status) == AppStatus.approved ||
            AppStatusHelper.of(LocalData.user!.status) ==
                AppStatus.missingParams)) {
      if (jobEntity.notRejectApplicants == null ||
          jobEntity.notRejectApplicants!.isEmpty) {
        return Center(
          child: CustomElevatedButton(
            onPressed: () {
              if (AppStatusHelper.of(LocalData.user!.status) ==
                  AppStatus.missingParams) {
                UpdateProfilePopUp.showShouldUpdatePopUp(
                  context,
                  onYesTap: () {
                    CustomMainRouter.pop();
                    _completeProfileCubit.getUniversites();
                    CustomMainRouter.push(
                      PersonalInformationRoute(
                        completeProfileCubit: _completeProfileCubit,
                        viewMode: false,
                        fromUpdatePopup: true,
                      ),
                    );
                  },
                );
              } else {
                _jobDetailsCubit.applyOnJob(id: jobId);
              }
            },
            width: 0.9.sw,
            height: 48.h,
            text: context.tr(AppLocalizationKeys.apply),
            textStyle: AppTextStyle.semiBold_16,
          ),
        );
      } else {
        if (AppStatusHelper.of(
                jobEntity.notRejectApplicants!.first.status) ==
            AppStatus.pending) {
          return Center(
            child: CustomElevatedButton(
              onPressed: () => _jobDetailsCubit.cancelJob(
                id: jobEntity.notRejectApplicants!.first.id ?? 0,
              ),
              width: 0.9.sw,
              height: 48.h,
              text: context.tr(AppLocalizationKeys.cancelJob),
              textStyle: AppTextStyle.semiBold_16,
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                if (JobDateHelper.showCancelButton(
                  currentTime,
                  jobEntity.startDate,
                  DateTimeHelper.formatTime(jobEntity.startTime),
                ))
                  CustomElevatedButton(
                    onPressed: () => _jobDetailsCubit.cancelJob(
                      id: jobEntity.notRejectApplicants!.first.id ?? 0,
                    ),
                    width: jobEntity.checkInTodayShift == null &&
                            jobEntity.checkoutTodayShift == null
                        ? 0.88.sw
                        : 0.42.sw,
                    height: 48.h,
                    text: context.tr(AppLocalizationKeys.cancelJob),
                    textStyle: AppTextStyle.semiBold_16,
                  ),
                if (jobEntity.checkInTodayShift != null)
                  CustomElevatedButton(
                    onPressed: () async {
                      final bool isValid =
                          await ViewsToolbox.checkPermision(Permission.camera);
                      if (isValid) {
                        String? id;
                        CustomMainRouter.push(
                          QrScannerWidget(),
                          then: (Object? idValue) {
                            id = idValue as String;
                            if (id != null && id!.isNotEmpty) {
                              _jobDetailsCubit.checkIn(
                                  id: int.parse(id!));
                            }
                          },
                        );
                      }
                    },
                    width: JobDateHelper.showCancelButton(
                      currentTime,
                      jobEntity.startDate,
                      DateTimeHelper.formatTime(jobEntity.startTime),
                    )
                        ? 0.42.sw
                        : 0.88.sw,
                    height: 48.h,
                    text: context.tr(AppLocalizationKeys.checkIn),
                    textStyle: AppTextStyle.semiBold_16,
                  ),
                if (jobEntity.checkoutTodayShift != null &&
                    jobEntity.checkInTodayShift == null)
                  CustomElevatedButton(
                    onPressed: () async {
                      final bool isValid =
                          await ViewsToolbox.checkPermision(Permission.camera);
                      if (isValid) {
                        String? id;
                        CustomMainRouter.push(
                          QrScannerWidget(),
                          then: (Object? idValue) {
                            id = idValue as String;
                            if (id != null && id!.isNotEmpty) {
                              _jobDetailsCubit.checkout(
                                  id: int.parse(id!));
                            }
                          },
                        );
                      }
                    },
                    width: JobDateHelper.showCancelButton(
                      currentTime,
                      jobEntity.startDate,
                      DateTimeHelper.formatTime(jobEntity.startTime),
                    )
                        ? 0.42.sw
                        : 0.88.sw,
                    height: 48.h,
                    text: context.tr(AppLocalizationKeys.checkOut),
                    textStyle: AppTextStyle.semiBold_16,
                  ),
              ],
            ),
          );
        }
      }
    }
    return const SizedBox.shrink();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Job Header
// ─────────────────────────────────────────────────────────────────────────────

class _JobHeader extends StatelessWidget {
  const _JobHeader({required this.job});

  final JobEntity job;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Palette.white,
      padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 16.h),
      child: Column(
        children: <Widget>[
          _CompanyLogo(logoUrl: job.vendor?.logoUrl),
          SizedBox(height: 12.h),
          AppText(
            text: job.title,
            style: AppTextStyle.bold_22,
            textColor: Palette.black_111111,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          if ((job.vendor?.name ?? '').isNotEmpty)
            AppText(
              text: job.vendor!.name,
              style: AppTextStyle.semiBold_16,
              textColor: Palette.secondary,
            ),
          SizedBox(height: 4.h),
          if ((job.vendorBranch ?? '').isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/svg/location-pin.svg',
                  width: 14.w,
                  colorFilter:
                      ColorFilter.mode(Palette.grey_757575, BlendMode.srcIn),
                ),
                SizedBox(width: 4.w),
                Flexible(
                  child: AppText(
                    text: job.vendorBranch!,
                    style: AppTextStyle.medium_14,
                    textColor: Palette.grey_757575,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 6.h,
            alignment: WrapAlignment.center,
            children: <Widget>[
              if ((job.jobCategory ?? '').isNotEmpty)
                _HeaderChip(label: job.jobCategory!),
              if (job.needsIntroVideo)
                _HeaderChip(
                  label: context.tr(AppLocalizationKeys.introVideoRequired),
                  svgIcon: 'assets/svg/video-icon.svg',
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CompanyLogo extends StatelessWidget {
  const _CompanyLogo({this.logoUrl});

  final String? logoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76.w,
      height: 76.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Palette.grey_e6e8f5, width: 2),
        color: Palette.grey_FAFAFA,
      ),
      child: ClipOval(
        child: logoUrl != null
            ? CachedNetworkImage(
                imageUrl: logoUrl!,
                fit: BoxFit.cover,
                memCacheWidth: 152,
                memCacheHeight: 152,
                errorWidget: (_, __, ___) => Icon(
                  Icons.business_rounded,
                  size: 36.r,
                  color: Palette.grey_A5A5A5,
                ),
              )
            : Icon(Icons.business_rounded, size: 36.r, color: Palette.grey_A5A5A5),
      ),
    );
  }
}

class _HeaderChip extends StatelessWidget {
  const _HeaderChip({required this.label, this.svgIcon});

  final String label;
  final String? svgIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Palette.grey_e6e8f5,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (svgIcon != null) ...<Widget>[
            SvgPicture.asset(svgIcon!, width: 13.w),
            SizedBox(width: 5.w),
          ],
          AppText(
            text: label,
            style: AppTextStyle.medium_13,
            textColor: Palette.secondary,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Description Tab
// ─────────────────────────────────────────────────────────────────────────────

class _DescriptionTab extends StatelessWidget {
  const _DescriptionTab({required this.job});

  final JobEntity job;

  @override
  Widget build(BuildContext context) {
    final int days = JobDateHelper.checkDateAndDays(
      start: DateTimeHelper.formatTime(job.startTime),
      end: DateTimeHelper.formatTime(job.endTime),
      startDate: job.startDate,
      dateTimeEndDate: job.endDate,
    ).days ?? 0;

    final String dateText = days > 1
        ? '${DateTimeHelper.formatDate(job.startDate.toIso8601String())} '
            '${context.tr(AppLocalizationKeys.to)} '
            '${DateTimeHelper.formatDate(job.endDate.toIso8601String())}'
        : DateTimeHelper.formatDate(job.startDate.toIso8601String());

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // ── Salary / Schedule Info Card ────────────────────────────
          Container(
            decoration: BoxDecoration(
              color: Palette.white,
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Palette.platinumColor.withValues(alpha: 0.9),
                  blurRadius: 16,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            child: Column(
              children: <Widget>[
                _InfoRow(
                  icon: Icons.monetization_on_rounded,
                  label: context.tr(AppLocalizationKeys.totalSalary),
                  value:
                      '${job.vendorPayTotalPrice.toStringAsFixed(0)} ${context.tr(AppLocalizationKeys.egp)}',
                  valueColor: Palette.secondary,
                ),
                _divider(),
                _InfoRow(
                  svgPath: 'assets/svg/time_icon.svg',
                  label: context.tr(AppLocalizationKeys.workingHours),
                  value:
                      '${DateTimeHelper.formatTime(job.startTime)}  –  ${DateTimeHelper.formatTime(job.endTime)}',
                ),
                _divider(),
                _InfoRow(
                  svgPath: 'assets/svg/job_calendar_icon.svg',
                  label: context.tr(AppLocalizationKeys.hoursShift),
                  value:
                      '${job.shiftHours} ${context.tr(AppLocalizationKeys.hoursShift)}',
                ),
                _divider(),
                _InfoRow(
                  svgPath: 'assets/svg/job_calendar_icon.svg',
                  label: context.tr(AppLocalizationKeys.days),
                  value: '$days ${context.tr(AppLocalizationKeys.days)}',
                ),
                _divider(),
                _InfoRow(
                  icon: Icons.calendar_today_rounded,
                  label: context.tr(AppLocalizationKeys.bookingDate),
                  value: dateText,
                ),
                _divider(),
                _InfoRow(
                  icon: Icons.payments_outlined,
                  label: context.tr(AppLocalizationKeys.perHour),
                  value:
                      '${job.vendorPayPricePerHour.toStringAsFixed(0)} ${context.tr(AppLocalizationKeys.egp)}',
                ),
              ],
            ),
          ),

          SizedBox(height: 22.h),

          // ── Job Description ────────────────────────────────────────
          AppText(
            text: context.tr(AppLocalizationKeys.jobDetails),
            style: AppTextStyle.bold_17,
            textColor: Palette.primaryColor,
          ),
          SizedBox(height: 8.h),
          AppText(
            text: (job.description?.isNotEmpty ?? false)
                ? job.description!
                : context.tr(AppLocalizationKeys.noDescription),
            style: AppTextStyle.medium_14,
            textColor: Palette.grey_4C4C4C,
          ),

          SizedBox(height: 22.h),

          // ── Location ──────────────────────────────────────────────
          AppText(
            text: context.tr(AppLocalizationKeys.location),
            style: AppTextStyle.bold_17,
            textColor: Palette.primaryColor,
          ),
          SizedBox(height: 8.h),
          if ((job.vendorBranch ?? '').isNotEmpty)
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  'assets/svg/location-pin.svg',
                  width: 15.w,
                  colorFilter: ColorFilter.mode(
                      Palette.secondary, BlendMode.srcIn),
                ),
                SizedBox(width: 6.w),
                Flexible(
                  child: AppText(
                    text:
                        '${context.tr(AppLocalizationKeys.branch)}  ${job.vendorBranch!}',
                    style: AppTextStyle.medium_15,
                    textColor: Palette.grey_4C4C4C,
                  ),
                ),
              ],
            ),
          SizedBox(height: 10.h),
          UnderlineTextWidget(
            text: context.tr(AppLocalizationKeys.openLocation),
            onTap: () => job.latitude == null
                ? null
                : ViewsToolbox.openMapWithCoords(
                    double.parse(job.latitude!),
                    double.parse(job.longitude!),
                  ),
          ),

          // ── How to get the job (unapproved profile) ───────────────
          if (LocalData.user != null && LocalData.user!.status == null) ...<Widget>[
            SizedBox(height: 22.h),
            const HowGetJobWidget(),
          ],

          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Widget _divider() => Divider(
        color: Palette.grey_e6e8f5,
        thickness: 1,
        height: 1,
      );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.icon,
    this.svgPath,
    this.valueColor,
  });

  final String label;
  final String value;
  final IconData? icon;
  final String? svgPath;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: <Widget>[
          if (icon != null)
            Icon(icon!, size: 20.r, color: Palette.secondary)
          else if (svgPath != null)
            SvgPicture.asset(
              svgPath!,
              width: 18.w,
              colorFilter:
                  ColorFilter.mode(Palette.secondary, BlendMode.srcIn),
            )
          else
            SizedBox(width: 20.r),
          SizedBox(width: 12.w),
          Expanded(
            child: AppText(
              text: label,
              style: AppTextStyle.medium_14,
              textColor: Palette.grey_7B7B7B,
            ),
          ),
          AppText(
            text: value,
            style: AppTextStyle.semiBold_14,
            textColor: valueColor ?? Palette.black_111111,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Company Tab
// ─────────────────────────────────────────────────────────────────────────────

class _CompanyTab extends StatelessWidget {
  const _CompanyTab({required this.job});

  final JobEntity job;

  @override
  Widget build(BuildContext context) {
    final VendorEntity? vendor = job.vendor;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ── Company Hero ─────────────────────────────────────────
          Container(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            decoration: BoxDecoration(
              color: Palette.white,
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Palette.platinumColor.withValues(alpha: 0.9),
                  blurRadius: 16,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                _CompanyLogo(logoUrl: vendor?.logoUrl),
                SizedBox(height: 12.h),
                AppText(
                  text: vendor?.name ?? '-',
                  style: AppTextStyle.bold_20,
                  textColor: Palette.primaryColor,
                  textAlign: TextAlign.center,
                ),
                if ((job.vendorBranch ?? '').isNotEmpty) ...<Widget>[
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.location_on_rounded,
                        size: 14.r,
                        color: Palette.grey_757575,
                      ),
                      SizedBox(width: 3.w),
                      Flexible(
                        child: AppText(
                          text: job.vendorBranch!,
                          style: AppTextStyle.medium_14,
                          textColor: Palette.grey_757575,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          SizedBox(height: 20.h),

          // ── About this Company ────────────────────────────────────
          AppText(
            text: context.tr(AppLocalizationKeys.companyTab),
            style: AppTextStyle.bold_17,
            textColor: Palette.primaryColor,
          ),
          SizedBox(height: 10.h),
          Container(
            decoration: BoxDecoration(
              color: Palette.white,
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Palette.platinumColor.withValues(alpha: 0.9),
                  blurRadius: 16,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            child: Column(
              children: <Widget>[
                _CompanyRow(
                  icon: Icons.business_rounded,
                  title: context.tr(AppLocalizationKeys.companyName),
                  value: vendor?.name ?? '-',
                ),
                Divider(color: Palette.grey_e6e8f5, thickness: 1, height: 1),
                _CompanyRow(
                  svgPath: 'assets/svg/location-pin.svg',
                  title: context.tr(AppLocalizationKeys.branch),
                  value: job.vendorBranch ?? '-',
                ),
                Divider(color: Palette.grey_e6e8f5, thickness: 1, height: 1),
                _CompanyRow(
                  icon: Icons.people_outline_rounded,
                  title: context.tr(AppLocalizationKeys.applicantsCount),
                  value: '${job.numOfApplicants}',
                ),
                if (vendor?.feesPerHour != null) ...<Widget>[
                  Divider(
                    color: Palette.grey_e6e8f5,
                    thickness: 1,
                    height: 1,
                  ),
                  _CompanyRow(
                    icon: Icons.monetization_on_outlined,
                    title: context.tr(AppLocalizationKeys.perHour),
                    value:
                        '${vendor!.feesPerHour!.toStringAsFixed(0)} ${context.tr(AppLocalizationKeys.egp)}',
                  ),
                ],
                Divider(color: Palette.grey_e6e8f5, thickness: 1, height: 1),
                _CompanyRow(
                  icon: Icons.open_in_new_rounded,
                  title: context.tr(AppLocalizationKeys.openLocation),
                  value: '',
                  isLink: true,
                  onTap: () => job.latitude == null
                      ? null
                      : ViewsToolbox.openMapWithCoords(
                          double.parse(job.latitude!),
                          double.parse(job.longitude!),
                        ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

class _CompanyRow extends StatelessWidget {
  const _CompanyRow({
    required this.title,
    required this.value,
    this.icon,
    this.svgPath,
    this.isLink = false,
    this.onTap,
  });

  final String title;
  final String value;
  final IconData? icon;
  final String? svgPath;
  final bool isLink;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: Row(
          children: <Widget>[
            if (icon != null)
              Icon(icon!, size: 20.r, color: Palette.secondary)
            else if (svgPath != null)
              SvgPicture.asset(
                svgPath!,
                width: 18.w,
                colorFilter:
                    ColorFilter.mode(Palette.secondary, BlendMode.srcIn),
              )
            else
              SizedBox(width: 20.r),
            SizedBox(width: 12.w),
            Expanded(
              child: AppText(
                text: title,
                style: AppTextStyle.medium_14,
                textColor: Palette.grey_7B7B7B,
              ),
            ),
            if (isLink)
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14.r,
                color: Palette.secondary,
              )
            else if (value.isNotEmpty)
              Flexible(
                child: AppText(
                  text: value,
                  style: AppTextStyle.semiBold_14,
                  textColor: Palette.black_111111,
                  textAlign: TextAlign.end,
                  maxLines: 1,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
