import 'package:flexiJobs/core/constants/assets_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginHeroSection extends StatelessWidget {
  const LoginHeroSection({super.key, required this.fadeAnim});

  final Animation<double> fadeAnim;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.26.sh,
      width: double.infinity,
      child: Center(
        child: FadeTransition(
          opacity: fadeAnim,
          child: SvgPicture.asset(AssetsPaths.hello, height: 140.h),
        ),
      ),
    );
  }
}
