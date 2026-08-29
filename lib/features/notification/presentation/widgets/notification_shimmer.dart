import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
        itemCount: 3,
        itemBuilder: (_, int i) => _ShimmerSection(itemCount: i == 0 ? 2 : 3),
      ),
    );
  }
}

class _ShimmerSection extends StatelessWidget {
  const _ShimmerSection({required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Date label placeholder
        Padding(
          padding: EdgeInsets.only(top: 18.h, bottom: 8.h),
          child: Container(
            height: 12.h,
            width: 64.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
        ),
        // Cards container
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Column(
            children: <Widget>[
              for (int i = 0; i < itemCount; i++) ...<Widget>[
                _ShimmerRow(),
                if (i < itemCount - 1)
                  Padding(
                    padding: EdgeInsets.only(left: 72.w),
                    child: const Divider(
                      height: 1,
                      thickness: 0.6,
                      color: Color(0xFFF5F5F5),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ShimmerRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Avatar circle
          Container(
            width: 44.r,
            height: 44.r,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12.w),
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 13.h,
                  width: 140.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
                SizedBox(height: 7.h),
                Container(
                  height: 11.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          // Time placeholder
          Container(
            height: 11.h,
            width: 36.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
        ],
      ),
    );
  }
}
