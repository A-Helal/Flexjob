import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/features/shared/cubit/locale_cubit/locale_cubit.dart';
import 'package:flutter/material.dart';

class DateTimeHelper {
  static LocaleCubit _localeCubit = getIt<LocaleCubit>();
  static String formatTime(String time) {
    try {
      DateFormat inputFormat = DateFormat("HH:mm", "en");
      DateTime dateTime = inputFormat.parseStrict(time); // safer parsing

      // Format to 12-hour time
      DateFormat outputFormat = DateFormat("h:mm a", "en");
      return outputFormat.format(dateTime);
    } catch (e) {
      return "Invalid time format";
    }
  }

  static String formatTimeString(String time) {
    try {
      DateTime dateTime = DateTime.parse(time);

      // Format to AM/PM
      String formatted = DateFormat("hh:mm a").format(dateTime);
      return formatted;
    } catch (e) {
      return "Invalid time format";
    }
  }

  static String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);

    // Format to 12-hour time

    return DateFormat("d MMMM y", _localeCubit.getCurrentLocale() == Locale('en', 'US') ? "en" : "ar").format(dateTime);
  }
}
