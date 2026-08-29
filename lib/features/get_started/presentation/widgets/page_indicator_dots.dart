import 'package:flexiJobs/core/responsive/app_dimensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flutter/material.dart';

class PageIndicatorDots extends StatelessWidget {
  const PageIndicatorDots({
    super.key,
    required this.pageCount,
    required this.currentPage,
  });

  final int pageCount;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        pageCount,
        (int index) => TweenAnimationBuilder<double>(
          tween: Tween<double>(
            begin: AppDimensions.w(7),
            end: currentPage == index ? AppDimensions.w(25) : AppDimensions.w(7),
          ),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          builder: (BuildContext context, double value, _) => Container(
            margin: AppDimensions.pH6,
            width: value,
            height: AppDimensions.h(7),
            decoration: BoxDecoration(
              color: currentPage == index ? Palette.secondary : Palette.grey_919191,
              borderRadius: AppDimensions.br20,
            ),
          ),
        ),
      ),
    );
  }
}
