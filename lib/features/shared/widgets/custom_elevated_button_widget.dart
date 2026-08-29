import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/theming/theme.dart';
import 'app_text.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    super.key,
    this.width,
    this.height,
    this.text,
    this.backgroundColor,
    required this.onPressed,
    this.textStyle,
    this.borderColor,
    this.textColor,
    this.radius,
    this.customChild,
    this.elevation,
    this.textLimit,
    this.fontWeight,
    this.fontSize,
    this.applyShadow = false,
    this.removeWidth = false,
    this.offestShadowY = 3,
    this.gradient,
    this.iconColor,
    this.showBorder = false,
    this.buttonStyle,
  });

  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? borderColor;
  final String? text;
  final AppTextStyle? textStyle;
  final Color? textColor;
  final void Function()? onPressed;
  final double? radius;
  final Widget? customChild;
  final double? elevation;
  final int? textLimit;
  final AppFontWeight? fontWeight;
  final num? fontSize;
  final bool applyShadow;
  final bool removeWidth;
  final double offestShadowY;
  final Gradient? gradient;
  final Color? iconColor;
  final bool showBorder;
  final ButtonStyle? buttonStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: removeWidth ? null : width ?? 1.sw,
      constraints: BoxConstraints(minHeight: height ?? 50.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: gradient,
        borderRadius: BorderRadius.circular(radius ?? 30.r),
        boxShadow: applyShadow
            ? <BoxShadow>[
                BoxShadow(
                  blurRadius: 6,
                  offset: Offset(0, offestShadowY),
                  color: const Color(0x29000000),
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        style:
            buttonStyle ??
            ButtonStyle(
              iconColor: WidgetStateProperty.all(
                iconColor ?? Palette.primaryBackgroundDarkTheme,
              ),
              backgroundColor: WidgetStateProperty.all(
                backgroundColor != null
                    ? backgroundColor
                    : Palette.primaryColor,
              ),
              elevation: WidgetStateProperty.resolveWith<double>(
                // As you said you dont need elevation. I'm returning 0 in both case
                (Set<WidgetState> states) {
                  if (elevation != null) {
                    return elevation!;
                  }
                  return 0; // Defer to the widget's default.
                },
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 20.r),
                  side: BorderSide(
                    color: showBorder
                        ? borderColor ??
                              (AppTheme.isDarkMode(context)
                                  ? Palette.black
                                  : Palette.white)
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            ),
        onPressed: onPressed == null
            ? null
            : () {
                FocusManager.instance.primaryFocus?.unfocus();
                onPressed!();
              },
        child:
            customChild ??
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: AppText(
              textAlign: TextAlign.center,
              text: text ?? "",
              style: textStyle,
              textColor:
                  textColor ??
                  (backgroundColor != null &&
                          backgroundColor != Palette.transparntColor
                      ? Palette.white
                      : AppTheme.inDarkMode(
                          context,
                          light:
                              backgroundColor == Palette.transparntColor
                              ? Palette.black
                              : Palette.white,
                          dark: Palette.white,
                        )),
              textLimit: textLimit,
              fontSize: 16,
              fontWeight: fontWeight ?? AppFontWeight.bold,
              lineHeight: 1,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              ),
            ),
      ),
    );
  }
}
