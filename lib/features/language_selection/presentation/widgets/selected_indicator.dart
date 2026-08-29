import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectedIndicator extends StatelessWidget {
  const SelectedIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.check_circle, color: Palette.primaryColor, size: 22.sp);
  }
}
