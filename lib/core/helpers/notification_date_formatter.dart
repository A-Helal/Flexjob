import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/helpers/language_helper.dart';
import 'package:flutter/material.dart';

class NotificationDateFormatter {
  const NotificationDateFormatter._();

  static String format(DateTime date, BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime dateOnly = DateTime(date.year, date.month, date.day);
    final int diffDays = today.difference(dateOnly).inDays;
    final String timeStr = DateFormat('hh:mm a', 'en').format(date);
    final String locale = LanguageHelper.isAr(context) ? 'ar' : 'en';

    if (diffDays == 0) return timeStr;

    if (diffDays == 1) {
      return context.tr(
        AppLocalizationKeys.at,
        args: <String>[context.tr(AppLocalizationKeys.yesterday), timeStr],
      );
    }

    if (diffDays > 1 && diffDays < 7) {
      final String weekday = DateFormat('EEEE', locale).format(date);
      return context.tr(AppLocalizationKeys.at, args: <String>[weekday, timeStr]);
    }

    return context.tr(AppLocalizationKeys.at, args: <String>[
      DateFormat('yyyy-MM-dd', 'en').format(date),
      timeStr,
    ]);
  }
}