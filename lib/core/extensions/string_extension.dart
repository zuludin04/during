import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

extension PriceFormat on int {
  String toPriceFormat() {
    var f = NumberFormat("#,##0", "id_ID");
    return f.format(this);
  }

  String changeDateFormat(String pattern) {
    initializeDateFormatting();
    var format = DateFormat(pattern, "id");
    return format.format(DateTime.fromMillisecondsSinceEpoch(this));
  }
}
