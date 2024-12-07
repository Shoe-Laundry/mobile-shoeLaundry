import 'package:intl/intl.dart';

extension CurrencyFormat on int {
  String get currencyFormatRp {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
    return formatCurrency.format(this);
  }
}
