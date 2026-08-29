import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shifts/presentation/screens/shifts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class NavigationMainScreen extends StatefulWidget {
  const NavigationMainScreen({super.key});

  @override
  State<NavigationMainScreen> createState() => _NavigationMainScreenState();
}

class _NavigationMainScreenState extends State<NavigationMainScreen> {
  List<String> screensTitles = <String>[
    "Jobs",
    "shifts",
    "settings",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AutoTabsScaffold(
        resizeToAvoidBottomInset: false,
        routes: <PageRouteInfo>[const JobsRoute(), const ShiftsRoute(), const MoreRoute()],
        bottomNavigationBuilder: (_, TabsRouter tabsRouter) {
          return buildBottomBar(tabsRouter);
        },
      ),
    );
  }

  Widget buildBottomBar(TabsRouter tabsRouter) {
    return PopScope(
      canPop: false,
      // onPopInvokedWithResult: (bool didPop, Object? dynamic) async {
      //   if (!didPop) {
      //     tabsRouter.setActiveIndex(0);
      //   }
      // },
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: SvgPicture.asset(
                "assets/svg/jobs-icon.svg",
                width: 25.w,
              ),
            ),
            activeIcon: Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: SvgPicture.asset(
                width: 25.w,
                "assets/svg/jobs-icon.svg",
                colorFilter: ColorFilter.mode(Palette.primaryColor, BlendMode.srcIn),
              ),
            ),
            label: context.tr(AppLocalizationKeys.jobs),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: SvgPicture.asset(
                "assets/svg/my-shifts.svg",
                width: 30.w,
              ),
            ),
            activeIcon: Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: SvgPicture.asset(
                "assets/svg/my-shifts.svg",
                width: 30.w,
                colorFilter: ColorFilter.mode(Palette.primaryColor, BlendMode.srcIn),
              ),
            ),
            label: context.tr(AppLocalizationKeys.myShifts),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: SvgPicture.asset(
                "assets/svg/more.svg",
                width: 26.w,
              ),
            ),
            activeIcon: Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: SvgPicture.asset(
                "assets/svg/more.svg",
                width: 26.w,
                colorFilter: ColorFilter.mode(Palette.primaryColor, BlendMode.srcIn),
              ),
            ),
            label: context.tr(AppLocalizationKeys.more),
          ),
        ],
        currentIndex: tabsRouter.activeIndex,
        onTap: (int index) {
          if (index == tabsRouter.activeIndex) {
            tabsRouter.stackRouterOfIndex(index)?.popUntilRoot();
          } else {
            tabsRouter.setActiveIndex(index);
          }
        },
      ),
    );
  }
}
