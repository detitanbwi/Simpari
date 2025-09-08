import 'package:intl/intl.dart';

String formatCurrency(int amount) {
  final formatter = NumberFormat.decimalPattern('id_ID');
  return 'Rp ${formatter.format(amount)}';
}