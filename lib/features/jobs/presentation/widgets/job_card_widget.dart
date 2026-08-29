import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/job_details/presentation/screens/job_details_screen.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    super.key,
    required this.job,
    this.routeFrom = JobDetailsRouteFrom.home,
  });

  final JobEntity job;
  final JobDetailsRouteFrom routeFrom;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Palette.platinumColor.withValues(alpha: 0.9),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () => CustomMainRouter.push(
            JobDetailsRoute(jobId: job.id, jobDetailsRouteFrom: routeFrom),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _CompanyHeader(job: job),
            Divider(color: Palette.primaryColor),
            _JobTitle(title: job.title),
            SizedBox(height: 8.h),
            _MetaRow(job: job),
            if (job.jobCategory != null || job.needsIntroVideo) ...<Widget>[
              SizedBox(height: 10.h),
              _CategoryChips(job: job),
            ],
            SizedBox(height: 14.h),
            _SalaryApplyRow(job: job),
          ],
        ),
      ),
    ),
      ),
    );
  }
}


class _CompanyHeader extends StatelessWidget {
  const _CompanyHeader({required this.job});

  final JobEntity job;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _CompanyLogo(logoUrl: job.vendor?.logoUrl),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppText(
                text: job.vendor?.name ?? '',
                style: AppTextStyle.bold_14,
                textColor: Palette.black_111111,
                maxLines: 1,
              ),
              SizedBox(height: 2.h),
              AppText(
                text: job.vendorBranch ?? '',
                style: AppTextStyle.medium_12,
                textColor: Palette.grey_7B7B7B,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CompanyLogo extends StatelessWidget {
  const _CompanyLogo({this.logoUrl});

  final String? logoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      height: 48.w,
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
                memCacheWidth: 96,
                memCacheHeight: 96,
                errorWidget: (_, __, ___) => _PlaceholderLogo(),
              )
            : _PlaceholderLogo(),
      ),
    );
  }
}

class _PlaceholderLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.business_rounded, size: 24.r, color: Palette.grey_A5A5A5);
  }
}

class _JobTitle extends StatelessWidget {
  const _JobTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text: title,
      style: AppTextStyle.bold_18,
      textColor: Palette.black_111111,
      maxLines: 2,
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.job});

  final JobEntity job;

  @override
  Widget build(BuildContext context) {
    final List<String> items = <String>[
      '${job.shiftHours} ${context.tr(AppLocalizationKeys.hoursShift)}',
      '${job.startTime} – ${job.endTime}',
    ];

    return Wrap(
      spacing: 6.w,
      children: <Widget>[
        for (int i = 0; i < items.length; i++) ...<Widget>[
          AppText(
            text: items[i],
            style: AppTextStyle.medium_13,
            textColor: Palette.grey_7B7B7B,
          ),
          if (i < items.length - 1)
            AppText(
              text: ':',
              style: AppTextStyle.medium_13,
              textColor: Palette.grey_A5A5A5,
            ),
        ],
      ],
    );
  }
}

class _CategoryChips extends StatelessWidget {
  const _CategoryChips({required this.job});

  final JobEntity job;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 6.h,
      children: <Widget>[
        if (job.jobCategory != null) _Chip(label: job.jobCategory!),
        if (job.needsIntroVideo)
          _Chip(
            label: context.tr(AppLocalizationKeys.introVideoRequired),
            icon: 'assets/svg/video-icon.svg',
          ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, this.icon});

  final String label;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Palette.grey_e6e8f5,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 240.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (icon != null) ...<Widget>[
              SvgPicture.asset(icon!, width: 14.w),
              SizedBox(width: 4.w),
            ],
            Flexible(
              child: AppText(
                text: label,
                style: AppTextStyle.medium_12,
                textColor: Palette.secondary,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SalaryApplyRow extends StatelessWidget {
  const _SalaryApplyRow({required this.job});

  final JobEntity job;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Icon(
          Icons.monetization_on_rounded,
          size: 22.r,
          color: Palette.secondary,
        ),
        SizedBox(width: 6.w),
        AppText(
          text:
              '${job.vendorPayTotalPrice.toStringAsFixed(0)} ${context.tr(AppLocalizationKeys.egp)}',
          style: AppTextStyle.bold_16,
          textColor: Palette.secondary,
          maxLines: 1,
        ),
        _ApplyButton(
          onTap: () => CustomMainRouter.push(
            JobDetailsRoute(
              jobId: job.id,
              jobDetailsRouteFrom: JobDetailsRouteFrom.home,
            ),
          ),
        ),
      ],
    );
  }
}

class _ApplyButton extends StatelessWidget {
  const _ApplyButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        backgroundColor: Palette.darkBlue,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      icon: Icon(Icons.arrow_forward_rounded, size: 14.r),
      label: AppText(
        text: context.tr(AppLocalizationKeys.applyNow),
        style: AppTextStyle.semiBold_13,
        textColor: Palette.white,
      ),
    );
  }
}
