import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/widgets.dart';

extension SizeExtension on BuildContext {
  double get sw => ScreenUtil().screenWidth;

  double get sh => ScreenUtil().screenHeight;

  double wp(double percent) => ScreenUtil().screenWidth * (percent / 100);

  double hp(double percent) => ScreenUtil().screenHeight * (percent / 100);
}
