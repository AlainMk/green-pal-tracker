import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String get dayOfWeekOrRelative {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.add(const Duration(days: -1));

    if (year == today.year && month == today.month && day == today.day) {
      return "Today";
    } else if (year == yesterday.year && month == yesterday.month && day == yesterday.day) {
      return "Yesterday";
    } else {
      return DateFormat.yMd().format(this);
    }
  }
}
