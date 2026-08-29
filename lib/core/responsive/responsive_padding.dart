import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' hide DeviceType;

import 'device_type.dart';

EdgeInsets responsivePadding(BuildContext context) {
  if (DeviceType.isTablet(context)) {
    return DeviceType.isLandscape(context)
        ? EdgeInsets.all(32.w)
        : EdgeInsets.all(24.w);
  }
  return EdgeInsets.all(16.w);
}

class ResponsivePadding {
  ResponsivePadding._();

  // ── Raw scale values ──────────────────────────────────────────────────────

  static double _h(BuildContext context) {
    if (DeviceType.isTablet(context)) {
      return DeviceType.isLandscape(context) ? 32.0 : 24.0;
    }
    return 16.0;
  }

  // ── Padding presets ───────────────────────────────────────────────────────

  static EdgeInsets horizontal(BuildContext context) =>
      EdgeInsets.symmetric(horizontal: _h(context).w);

  static EdgeInsets all(BuildContext context) => EdgeInsets.all(_h(context).w);

  static EdgeInsets withVertical(
    BuildContext context, {
    double top = 0,
    double bottom = 0,
  }) => EdgeInsets.fromLTRB(_h(context).w, top.h, _h(context).w, bottom.h);

  static EdgeInsets listPadding(BuildContext context) =>
      EdgeInsets.fromLTRB(_h(context).w, 0, _h(context).w, 100.h);
}
