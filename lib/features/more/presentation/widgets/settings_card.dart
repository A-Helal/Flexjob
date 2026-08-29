import 'package:flexiJobs/features/more/presentation/widgets/settings_item.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    super.key,
    required this.title,
    required this.items,
  });

  final String title;
  final List<SettingsItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
            child: AppText(
              text: title,
              style: AppTextStyle.bold_16,
              textColor: const Color(0xFF1A1A2E),
            ),
          ),
          ...items,
        ],
      ),
    );
  }
}