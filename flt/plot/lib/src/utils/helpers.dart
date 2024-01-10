import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(date);
}

int parseHex(String code) => int.parse(code.replaceFirst('0x', ''), radix: 16);

String intToHex(int value) {
  return '0x${value.toRadixString(16).toUpperCase()}';
}
