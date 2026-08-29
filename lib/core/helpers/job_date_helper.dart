class JobDateHelper {
  static DateAndDays checkDateAndDays({
    required String start,
    required String end,
    required DateTime startDate,
    required DateTime dateTimeEndDate,
  }) {
    DateTime? endDate;
    int startHour = int.parse(start.split(":").first);
    int endHour = int.parse(end.split(":").first);

    if (start.toLowerCase().contains("pm") && startHour != 12) {
      startHour = startHour + 12;
    }
    if (end.toLowerCase().contains("pm") && endHour != 12) {
      endHour = endHour + 12;
    }
    if (startHour == 12 && start.toLowerCase().contains("pm")) {
      startHour = 12;
    }
    if (endHour == 12 && end.toLowerCase().contains("am")) {
      endHour = 0;
    }
    if (endHour == 12 && end.toLowerCase().contains("pm")) {
      endHour = 12;
    }
    if (startHour == 12 && start.toLowerCase().contains("am")) {
      startHour = 0;
    }
    int days;
    if (startHour > endHour) {
      endDate = dateTimeEndDate.subtract(const Duration(days: 1));
      days = endDate.difference(startDate).inDays;
    } else {
      days = dateTimeEndDate.difference(startDate).inDays;
    }

    return DateAndDays(days: days + 1, endDate: endDate ?? dateTimeEndDate);
  }

  static bool showCancelButton(DateTime current, DateTime startDate, String startTime) {
    String start = startTime.split(" ").first;
    int startHour = int.parse(start.split(":").first);
    int startMin = int.parse(start.split(":").last);
    if (startTime.toLowerCase().contains("pm")) {
      startHour = startHour + 12;
    }
    if (startHour == 12) {
      startHour = 0;
    }
    DateTime date = DateTime(current.year, current.month, current.day);
    if (date.isBefore(startDate) ||
        (date.day == startDate.day &&
            date.month == startDate.month &&
            date.year == startDate.year &&
            (current.hour < startHour || current.hour == startHour && current.minute < startMin))) {
      return true;
    }
    return false;
  }
}

class DateAndDays {
  DateAndDays({this.endDate, this.days});
  DateTime? endDate;
  int? days;
}
