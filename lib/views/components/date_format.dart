import 'package:intl/intl.dart';

class TimeAgo {
  static String timeAgoSinceDate(String dateString,
      {bool numericDates = true}) {
    DateTime notificationDate = DateTime.parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);
    if (difference.inDays > 8) {
      return DateFormat('d MMM y').format(notificationDate);
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Minggu Lalu';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} Hari Lalu';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Kemarin';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} Jam Lalu';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : '1 Jam';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} Menit Lalu';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : '1 Menit';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} Detik Lalu';
    } else {
      return 'Baru Saja';
    }
  }
}
