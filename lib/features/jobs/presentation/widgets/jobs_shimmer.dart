import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class JobsShimmer extends StatelessWidget {
  const JobsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _shimmerBox(height: 48.h, width: double.infinity, radius: 12),
            SizedBox(height: 16.h),
            _shimmerBox(height: 54.h, width: double.infinity, radius: 12),
            SizedBox(height: 20.h),
            _shimmerBox(height: 20.h, width: 120.w, radius: 6),
            SizedBox(height: 12.h),
            SizedBox(
              height: 320.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (_, __) => Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: _shimmerBox(height: 300.h, width: 240.w, radius: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmerBox({required double height, required double width, double radius = 8}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}