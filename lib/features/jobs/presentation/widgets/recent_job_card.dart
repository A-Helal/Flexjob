import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/job_details/presentation/screens/job_details_screen.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecentJobCard extends StatelessWidget {
  const RecentJobCard({
    super.key,
    required this.job,
    this.routeFrom = JobDetailsRouteFrom.home,
  });

  final JobEntity job;
  final JobDetailsRouteFrom routeFrom;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Palette.platinumColor.withValues(alpha: 0.8),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () => CustomMainRouter.push(
            JobDetailsRoute(jobId: job.id, jobDetailsRouteFrom: routeFrom),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
            child: Row(
          children: <Widget>[
            _RecentJobLogo(logoUrl: job.vendor?.logoUrl),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AppText(
                    text: job.title,
                    style: AppTextStyle.bold_16,
                    textColor: Palette.black_111111,
                    maxLines: 1,
                  ),
                  SizedBox(height: 5.h),
                  _RecentJobMeta(job: job),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16.r,
              color: Palette.grey_A5A5A5,
            ),
          ],
        ),
      ),
    ),
      ),
    );
  }
}

class _RecentJobLogo extends StatelessWidget {
  const _RecentJobLogo({this.logoUrl});

  final String? logoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Palette.grey_e6e8f5, width: 1.5),
        color: Palette.grey_FAFAFA,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9.r),
        child: logoUrl != null
            ? CachedNetworkImage(
                imageUrl: logoUrl!,
                fit: BoxFit.cover,
                memCacheWidth: 96,
                memCacheHeight: 96,
                errorWidget: (_, __, ___) => const _FallbackLogo(),
              )
            : const _FallbackLogo(),
      ),
    );
  }
}

class _FallbackLogo extends StatelessWidget {
  const _FallbackLogo();

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.business_rounded, size: 22.r, color: Palette.grey_A5A5A5);
  }
}

class _RecentJobMeta extends StatelessWidget {
  const _RecentJobMeta({required this.job});

  final JobEntity job;

  @override
  Widget build(BuildContext context) {
    final String company = job.vendor?.name ?? '';
    final String branch = job.vendorBranch ?? '';

    return Row(
      children: <Widget>[
        if (company.isNotEmpty) ...<Widget>[
          Flexible(
            child: AppText(
              text: company,
              style: AppTextStyle.medium_13,
              textColor: Palette.grey_7B7B7B,
              maxLines: 1,
            ),
          ),
        ],
        if (company.isNotEmpty && branch.isNotEmpty) ...<Widget>[
          AppText(
            text: '  •  ',
            style: AppTextStyle.medium_13,
            textColor: Palette.grey_A5A5A5,
          ),
        ],
        if (branch.isNotEmpty) ...<Widget>[
          SvgPicture.asset(
            'assets/svg/location-pin.svg',
            width: 11.w,
            colorFilter:
                ColorFilter.mode(Palette.grey_A5A5A5, BlendMode.srcIn),
          ),
          SizedBox(width: 3.w),
          Flexible(
            child: AppText(
              text: branch,
              style: AppTextStyle.medium_13,
              textColor: Palette.grey_7B7B7B,
              maxLines: 1,
            ),
          ),
        ],
      ],
    );
  }
}
