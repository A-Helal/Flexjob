import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LanguageFlag extends StatelessWidget {
  const LanguageFlag({super.key, required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.r),
      child: SvgPicture.asset(
        assetPath,
        width: 48.w,
        height: 36.h,
        fit: BoxFit.cover,
      ),
    );
  }
}
