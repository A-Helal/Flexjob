import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotifyCard extends StatelessWidget {
  const NotifyCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.completionPercent,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final double completionPercent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 18.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Palette.primaryColor, Palette.blue_292F89, Palette.blue_4450BB],
            ),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Palette.primaryColor.withValues(alpha: 0.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: title,
                      style: AppTextStyle.bold_16,
                      textColor: Palette.white,
                    ),
                    SizedBox(height: 4.h),
                    AppText(
                      text: subtitle,
                      style: AppTextStyle.medium_14,
                      textColor: Palette.grey_D9DDDE,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              _CircularProgress(percent: completionPercent),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircularProgress extends StatelessWidget {
  const _CircularProgress({required this.percent});

  final double percent;

  @override
  Widget build(BuildContext context) {
    final int display = (percent * 100).round();

    return SizedBox(
      width: 52.w,
      height: 52.w,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CircularProgressIndicator(
            value: percent,
            strokeWidth: 5,
            backgroundColor: Palette.grey_e6e8f5,
            valueColor: AlwaysStoppedAnimation<Color>(Palette.secondary),
            strokeCap: StrokeCap.round,
          ),
          Center(
            child: AppText(
              text: '$display%',
              style: AppTextStyle.bold_13,
              textColor: Palette.white,
            ),
          ),
        ],
      ),
    );
  }
}
