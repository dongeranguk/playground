import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String get formattedDateTime => DateFormat('yyyy년 MM월 dd일 HH:mm:dd').format(this);

  String customFormat() {
    DateTime now = DateTime.now();
    if (day == now.day) {
      if (hour > 12) {
        return DateFormat('오후 HH:mm').format(this);
    }
      return DateFormat('오전 HH:mm').format(this);

    } else if (year == now.year) {
      return DateFormat('MM.dd').format(this);
    } else {
      return DateFormat('yy.MM.dd').format(this);
    }
  }
}
