import 'package:flutter/widgets.dart';
import 'device_type.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tabletPortrait;
  final Widget? tabletLandscape;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tabletPortrait,
    this.tabletLandscape,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = DeviceType.isTablet(context);
    final isLandscape = DeviceType.isLandscape(context);

    if (!isTablet) {
      return mobile;
    }

    if (isLandscape) {
      return tabletLandscape ?? tabletPortrait ?? mobile;
    } else {
      return tabletPortrait ?? mobile;
    }
  }
}
