import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class DateActionsComponent {
  final DateTime? date;

  DateActionsComponent({required this.date});

  String toJalali() {
    return Jalali.fromDateTime(date ?? DateTime.now()).formatMediumDate();
  }

  static String formatSecondsToMinutes(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  static String toLabel(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    // Future dates
    if (difference.isNegative) {
      return 'همین الان';
    }

    // Less than 1 hour
    if (difference.inHours < 1) {
      return 'دقایقی قبل';
    }

    // Less than 12 hours
    if (difference.inHours < 12) {
      return 'ساعاتی قبل';
    }

    // Today
    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return 'امروز';
    }

    // Yesterday
    final yesterday = now.subtract(const Duration(days: 1));

    if (dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day) {
      return 'دیروز';
    }

    // Older dates -> Jalali date
    final jalaliDate = DateTimeExtensions(dateTime).toJalali();

    return '${jalaliDate.year}/${jalaliDate.month.toString().padLeft(2, '0')}/${jalaliDate.day.toString().padLeft(2, '0')}';
  }
}
