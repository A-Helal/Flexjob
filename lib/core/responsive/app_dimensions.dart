import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDimensions {
  AppDimensions._();

  // ── Padding ──────────────────────────────────────────────────────────────
  static EdgeInsets get p8 => EdgeInsets.all(8.w);
  static EdgeInsets get p12 => EdgeInsets.all(12.w);
  static EdgeInsets get p16 => EdgeInsets.all(16.w);
  static EdgeInsets get p20 => EdgeInsets.all(20.w);

  static EdgeInsets get pH6 => EdgeInsets.symmetric(horizontal: 6.w);
  static EdgeInsets get pH8 => EdgeInsets.symmetric(horizontal: 8.w);
  static EdgeInsets get pH10 => EdgeInsets.symmetric(horizontal: 10.w);
  static EdgeInsets get pH12 => EdgeInsets.symmetric(horizontal: 12.w);
  static EdgeInsets get pH16 => EdgeInsets.symmetric(horizontal: 16.w);
  static EdgeInsets get pH20 => EdgeInsets.symmetric(horizontal: 20.w);
  static EdgeInsets get pH24 => EdgeInsets.symmetric(horizontal: 24.w);

  static EdgeInsets get pV4 => EdgeInsets.symmetric(vertical: 4.h);
  static EdgeInsets get pV8 => EdgeInsets.symmetric(vertical: 8.h);
  static EdgeInsets get pV12 => EdgeInsets.symmetric(vertical: 12.h);
  static EdgeInsets get pV32 => EdgeInsets.symmetric(vertical: 32.h);

  static EdgeInsets pHV({required double h, required double v}) =>
      EdgeInsets.symmetric(horizontal: h.w, vertical: v.h);

  static EdgeInsets pLTRB(double l, double t, double r, double b) =>
      EdgeInsets.fromLTRB(l.w, t.h, r.w, b.h);

  static EdgeInsets pOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      EdgeInsets.only(
        left: left.w,
        top: top.h,
        right: right.w,
        bottom: bottom.h,
      );

  // ── Border Radius ────────────────────────────────────────────────────────
  static double get r4 => 4.r;
  static double get r6 => 6.r;
  static double get r8 => 8.r;
  static double get r10 => 10.r;
  static double get r12 => 12.r;
  static double get r14 => 14.r;
  static double get r16 => 16.r;
  static double get r20 => 20.r;

  static BorderRadius get br4 => BorderRadius.circular(4.r);
  static BorderRadius get br6 => BorderRadius.circular(6.r);
  static BorderRadius get br8 => BorderRadius.circular(8.r);
  static BorderRadius get br10 => BorderRadius.circular(10.r);
  static BorderRadius get br12 => BorderRadius.circular(12.r);
  static BorderRadius get br14 => BorderRadius.circular(14.r);
  static BorderRadius get br16 => BorderRadius.circular(16.r);
  static BorderRadius get br20 => BorderRadius.circular(20.r);

  // ── Icon Sizes ───────────────────────────────────────────────────────────
  static double get icon14 => 14.r;
  static double get icon16 => 16.r;
  static double get icon18 => 18.r;
  static double get icon20 => 20.r;
  static double get icon22 => 22.r;
  static double get icon24 => 24.r;
  static double get icon25 => 25.r;
  static double get icon32 => 32.r;
  static double get icon40 => 40.r;
  static double get icon90 => 90.r;

  // ── Common Sizes ─────────────────────────────────────────────────────────
  static double get s1 => 1.r;
  static double get s2 => 2.r;
  static double get s3 => 3.r;
  static double get s4 => 4.r;
  static double get s5 => 5.r;
  static double get s8 => 8.r;
  static double get s12 => 12.r;
  static double get s16 => 16.r;
  static double get s20 => 20.r;
  static double get s24 => 24.r;
  static double get s28 => 28.r;
  static double get s32 => 32.r;
  static double get s35 => 35.r;
  static double get s40 => 40.r;
  static double get s48 => 48.r;
  static double get s50 => 50.r;
  static double get s56 => 56.r;
  static double get s60 => 60.r;
  static double get s72 => 72.r;
  static double get s80 => 80.r;
  static double get s90 => 90.r;
  static double get s100 => 100.r;
  static double get s120 => 120.r;
  static double get s130 => 130.r;
  static double get s180 => 180.r;
  static double get s200 => 200.r;
  static double get s250 => 250.r;
  static double get s280 => 280.r;
  static double get s400 => 400.r;

  // ── Width / Height (screen-proportional) ─────────────────────────────────
  static double w(double v) => v.w;
  static double h(double v) => v.h;
}
