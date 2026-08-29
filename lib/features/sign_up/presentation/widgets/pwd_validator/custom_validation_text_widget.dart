import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';

/// ValidationTextWidget that represent style of each one of them and shows as list of condition that you want to the app user
class CustomValidationTextWidget extends StatelessWidget {
  CustomValidationTextWidget(
      {required this.color, required this.text, required this.value});
  final Color color;
  final String text;
  final int? value;

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        color == Palette.primaryColor
            ? Icon(
                Icons.task_alt_rounded,
                size: 15,
                color: Palette.primaryColor,
              )
            : const Icon(
                Icons.circle_outlined,
                size: 15,
                color: Palette.grey_A5A5A5,
              ),
        5.widthBox,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2 * 0.03),
          child: AppText(
            text: text,
            style: AppTextStyle.medium_14,
            textColor: color,
          ),
        )
      ],
    );
  }
}
