import 'package:intl/intl.dart';

class DateTimeConverter {
  static String dateTimeToDateText(DateTime dateTime) {
    return '${DateFormat.MMM().format(dateTime)} ${dateTime.day}, ${dateTime.year}';
  }

  static String dateTimeToTimeText(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }
}
