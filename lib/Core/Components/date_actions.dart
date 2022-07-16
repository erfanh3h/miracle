import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class DateActionsComponent {
  final DateTime? date;

  DateActionsComponent({
    required this.date,
  });

  String toJalali() {
    return Jalali.fromDateTime(date ?? DateTime.now()).formatMediumDate();
  }
}
