import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeroBackground extends StatelessWidget {
  const HeroBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Palette.primaryColor,
            Palette.primaryColor.withValues(alpha: 0.75),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(800.r),
          bottomRight: Radius.circular(800.r),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -40,
            right: -30,
            child: _DecorativeCircle(size: 130.w, opacity: 0.07),
          ),
          Positioned(
            top: 40,
            left: -20,
            child: _DecorativeCircle(size: 80.w, opacity: 0.05),
          ),
        ],
      ),
    );
  }
}

class _DecorativeCircle extends StatelessWidget {
  const _DecorativeCircle({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: opacity),
      ),
    );
  }
}
