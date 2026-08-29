import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/language_selection/presentation/widgets/language_flag.dart';
import 'package:flexiJobs/features/language_selection/presentation/widgets/selected_indicator.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard({
    super.key,
    required this.title,
    required this.assetPath,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String assetPath;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onTap,
        child: Ink(
          decoration: _cardDecoration,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: <Widget>[
              LanguageFlag(assetPath: assetPath),
              16.widthBox,
              Expanded(
                child: AppText(
                  text: title,
                  style: AppTextStyle.semiBold_16,
                  textColor: Palette.grey_2C2C2C,
                ),
              ),
              if (selected) const SelectedIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration get _cardDecoration => BoxDecoration(
    borderRadius: BorderRadius.circular(12.r),
    border: Border.all(
      color: selected ? Palette.primaryColor : Palette.grey_EBEBEB,
      width: selected ? 2 : 1,
    ),
    color: selected
        ? Palette.primaryColor.withValues(alpha: 0.06)
        : Palette.white,
  );
}