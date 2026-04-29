String formatDayMonth(DateTime date) {
  // مصفوفة أسماء الأشهر بالعربي
  const months = [
    "يناير",
    "فبراير",
    "مارس",
    "أبريل",
    "مايو",
    "يونيو",
    "يوليو",
    "أغسطس",
    "سبتمبر",
    "أكتوبر",
    "نوفمبر",
    "ديسمبر",
  ];

  final day = date.day; // رقم اليوم
  final month = months[date.month - 1]; // اسم الشهر

  return "$day $month";
}

String formatTimeToArabic(String? isoString) {
  if (isoString == null || isoString.isEmpty || isoString == "null") {
    return "--:--";
  }

  final date = DateTime.parse(isoString).toLocal();

  int hour = date.hour;
  final minute = date.minute.toString().padLeft(2, '0');
  String period = "ص";

  if (hour >= 12) {
    period = "م";
    if (hour > 12) hour -= 12;
  }

  if (hour == 0) hour = 12;

  return "$hour:$minute $period";
}
