class TimeHelper {
  /// تحويل Timestamp إلى وقت عربي مثل 4:05 ص
  static String formatToArabicTime(DateTime date) {
    int hour = date.hour;
    int minute = date.minute;

    final isPM = hour >= 12;
    final suffix = isPM ? "م" : "ص";

    hour = hour % 12;
    if (hour == 0) hour = 12;

    final minuteStr = minute.toString().padLeft(2, '0');

    return "$hour:$minuteStr $suffix";
  }

  /// تحويل "HH:mm" إلى Duration بسرعة كبيرة
  static Duration toDuration(String time) {
    final parts = time.split(':');
    final h = int.parse(parts[0]);
    final m = int.parse(parts[1]);
    return Duration(hours: h, minutes: m);
  }

  static String formatDurationToArabic(Duration duration) {
    int totalMinutes = duration.inMinutes;

    int hour = totalMinutes ~/ 60;
    int minute = totalMinutes % 60;

    String period = "ص";

    // تحديد AM/PM
    if (hour >= 12) {
      period = "م";
      if (hour > 12) hour -= 12;
    }

    if (hour == 0) hour = 12;

    final minuteStr = minute.toString().padLeft(2, '0');

    return "$hour:$minuteStr $period";
  }

  /// حساب الفرق بين start و end
  static Duration difference(String start, String end) {
    final startDur = toDuration(start);
    var endDur = toDuration(end);

    // لو انتهى في اليوم التالي
    if (endDur < startDur) {
      endDur += const Duration(days: 1);
    }

    return endDur - startDur;
  }

  /// ترجع الساعات كرقم double
  static double hoursBetween(String start, String end) {
    final diff = difference(start, end);
    return diff.inMinutes / 60.0;
  }

  static String formatDateToArabic(DateTime date) {
    const arabicDays = [
      "الأحد",
      "الاثنين",
      "الثلاثاء",
      "الأربعاء",
      "الخميس",
      "الجمعة",
      "السبت",
    ];

    final dayName = arabicDays[date.weekday % 7];

    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;

    return "$dayName $day/$month/$year";
  }

  static String arabicTimeTo24(String time) {
    // مثال input: "9:02 م"
    final parts = time.split(' ');
    final timePart = parts[0]; // 9:02
    final period = parts[1]; // ص أو م

    final hm = timePart.split(':');
    int hour = int.parse(hm[0]);
    int minute = int.parse(hm[1]);

    // تحويل AM / PM
    if (period == "م" && hour != 12) {
      hour += 12;
    } else if (period == "ص" && hour == 12) {
      hour = 0;
    }

    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');

    return "$h:$m:00";
  }
}
