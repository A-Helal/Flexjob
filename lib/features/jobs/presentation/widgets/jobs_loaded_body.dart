import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/app_data/domain/entities/app_user_entity.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/helpers/use_helper.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/job_details/presentation/screens/job_details_screen.dart';
import 'package:flexiJobs/features/jobs/domain/entities/home_data_entity.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/features/jobs/domain/entities/jobs_list_entity.dart';
import 'package:flexiJobs/features/jobs/presentation/cubit/jobs_cubit.dart';
import 'package:flexiJobs/features/jobs/presentation/widgets/job_card_widget.dart';
import 'package:flexiJobs/features/jobs/presentation/widgets/notify_card.dart';
import 'package:flexiJobs/features/jobs/presentation/widgets/recent_job_card.dart';
import 'package:flexiJobs/features/jobs/presentation/widgets/upcoming_shift_card.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobsLoadedBody extends StatelessWidget {
  const JobsLoadedBody({super.key, required this.state, required this.cubit});

  final JobsLoaded state;
  final JobsCubit cubit;

  @override
  Widget build(BuildContext context) {
    final HomeDataEntity data = state.data;
    final AppUserEntity? user = LocalData.user;
    final bool showProfileBanner =
        user?.status == null || user?.status == 'pending';

    final List<JobEntity> allJobs = data.nonEmptyCategories
        .expand((JobsListEntity c) => c.jobs)
        .toList();

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: 28.h),
      children: <Widget>[
        SizedBox(height: 12.h),

        if (showProfileBanner)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: NotifyCard(
              title: _resolveNotifyTitle(context, user?.status, UseHelper.isGuest()),
              subtitle: context.tr(AppLocalizationKeys.completeProfileSubtitle),
              completionPercent: _computeCompletion(user),
              onTap: _resolveNotifyTap(user?.status),
            ),
          ),

        if (data.upcomingShift != null && data.upcomingShift!.hasCheckedIn)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
            child: UpcomingShiftCard(
              shift: data.upcomingShift!,
              onTap: () => CustomMainRouter.push(
                JobDetailsRoute(
                  jobId: data.upcomingShift!.jobId,
                  jobDetailsRouteFrom: JobDetailsRouteFrom.home,
                ),
              ),
            ),
          ),

        SizedBox(height: 10.h),

        if (state.isFiltering)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: CircularProgressIndicator.adaptive(),
            ),
          )
        else if (allJobs.isEmpty)
          const NoDataWidget(hideButton: true)
        else ...<Widget>[
          // ── Recommended Jobs ─────────────────────────────────────────
          _SectionHeader(
            title: context.tr(AppLocalizationKeys.recommendedJobs),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            height: 260.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 4.w, right: 16.w),
              itemCount: allJobs.length,
              itemBuilder: (BuildContext ctx, int index) => JobCard(
                job: allJobs[index],
                routeFrom: JobDetailsRouteFrom.home,
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // ── Recent Jobs ───────────────────────────────────────────────
          _SectionHeader(
            title: context.tr(AppLocalizationKeys.recentJobs),
          ),
          SizedBox(height: 8.h),
          ...allJobs.map(
            (JobEntity job) => RecentJobCard(
              job: job,
              routeFrom: JobDetailsRouteFrom.home,
            ),
          ),
        ],
      ],
    );
  }

  double _computeCompletion(AppUserEntity? user) {
    if (user == null) return 0.0;

    int filled = 0;
    const int total = 8;

    if (user.name != null && user.name!.isNotEmpty) filled++;
    if (user.gender != null && user.gender!.isNotEmpty) filled++;
    if (user.birthdate != null && user.birthdate!.isNotEmpty) filled++;
    if (user.nationalId != null && user.nationalId!.isNotEmpty) filled++;

    final bool hasProfilePic =
        user.attachments?.any((a) => a.type == 'profile_picture') ?? false;
    if (hasProfilePic) filled++;

    final bool hasIdDoc =
        user.attachments?.any((a) => a.type != 'profile_picture') ?? false;
    if (hasIdDoc) filled++;

    if (user.jobCategories != null && user.jobCategories!.isNotEmpty) filled++;
    if (user.paymentable != null ||
        user.instapays != null ||
        user.mobileWallets != null) filled++;

    return filled / total;
  }

  String _resolveNotifyTitle(
    BuildContext context,
    String? status,
    bool isGuest,
  ) {
    if (isGuest) return context.tr(AppLocalizationKeys.createAccountGuest);
    if (status == 'pending') {
      return context.tr(AppLocalizationKeys.yourProfileUnderReview);
    }
    return context.tr(AppLocalizationKeys.completeYourProfileTitle);
  }

  VoidCallback _resolveNotifyTap(String? status) {
    if (UseHelper.isGuest()) return () => CustomMainRouter.push(SignUpRoute());
    if (status == 'pending') return () {};
    return () => CustomMainRouter.push(CompleteProfileRoute());
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: AppText(
        text: title,
        textColor: Palette.primaryColor,
        style: AppTextStyle.bold_20,
      ),
    );
  }
}
