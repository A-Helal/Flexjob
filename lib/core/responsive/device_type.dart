import 'package:flutter/widgets.dart';

class DeviceType {
  static const double tabletBreakpoint = 600;

  // Mobile
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide < tabletBreakpoint;

  // Tablet (Portrait + Landscape)
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= tabletBreakpoint;

  // Orientation
  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  // Tablet Portrait
  static bool isTabletPortrait(BuildContext context) =>
      isTablet(context) && !isLandscape(context);

  // Tablet Landscape
  static bool isTabletLandscape(BuildContext context) =>
      isTablet(context) && isLandscape(context);
}
