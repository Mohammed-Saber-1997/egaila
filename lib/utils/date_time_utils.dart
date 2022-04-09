import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart' as intl;

class DateTimeUtils {

  static final dateFormatter = intl.DateFormat('yyyy/MM/dd | hh:mm a');

  static String convertDateFromString(String strDate) {
    DateTime date = DateTime.parse(strDate);
    return formatDate(date, [yyyy, '/', mm, '/', dd]);
  }

  static void convertStringFromDate() {
    final todayDate = DateTime.now();
    print(formatDate(todayDate,
        [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss, ' ', am]));
  }
}
