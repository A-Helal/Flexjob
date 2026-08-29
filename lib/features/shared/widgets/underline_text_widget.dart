import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';

class UnderlineTextWidget extends StatelessWidget {
  const UnderlineTextWidget({super.key, required this.text, this.textColor, this.onTap, this.style});
  final String text;
  final Color? textColor;
  final void Function()? onTap;
  final AppTextStyle? style;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppText(
        text: context.tr(
          text,
        ),
        textColor: textColor ?? Palette.purple_8E29DE,
        style: style ?? AppTextStyle.medium_16,
        textAlign: TextAlign.center,
      ),
    );
  }
}
