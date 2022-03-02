import 'package:intl/intl.dart';

final formatter = NumberFormat("#,###");

class Formatter {
  static String number(double num) {
    final formatter = NumberFormat("#,###");

    return formatter.format(num);
  }

  static String count(int value) {
    if (value >= 1000) {
      return (value / 1000.0).toStringAsFixed(1) + 'k';
    } else {
      return value.toString();
    }
  }
}
