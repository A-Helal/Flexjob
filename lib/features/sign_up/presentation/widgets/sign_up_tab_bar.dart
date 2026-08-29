import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpTabBar extends StatelessWidget {
  const SignUpTabBar({super.key, required this.controller});

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF7F8FA),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: TabBar(
          controller: controller,
          padding: EdgeInsets.all(4.r),
          labelPadding: EdgeInsets.zero,
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          indicator: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(9.r),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Palette.primaryColor.withValues(alpha: 0.09),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Palette.primaryColor,
          unselectedLabelColor: const Color(0xFF8A8A9A),
          labelStyle: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            fontFamily: 'Montserrat',
          ),
          tabs: <Widget>[
            Tab(text: context.tr('loginOption1')),
            Tab(text: context.tr('loginOption2')),
          ],
        ),
      ),
    );
  }
}
