import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/features/jobs/domain/entities/jobs_list_entity.dart';
import 'package:flexiJobs/features/jobs/presentation/widgets/job_card_widget.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/underline_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobListSection extends StatelessWidget {
  const JobListSection({super.key, required this.category});

  final JobsListEntity category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppText(
                text: category.name,
                textColor: Palette.primaryColor,
                style: AppTextStyle.bold_20,
              ),
              UnderlineTextWidget(
                text: context.tr(AppLocalizationKeys.viewAll),
                onTap: () => CustomMainRouter.push(
                  JobListRoute(
                    categoryId: category.id,
                    categoryName: category.name,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        ...category.jobs.map(
          (JobEntity job) => JobCard(job: job),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
