import 'package:csv/csv.dart';

class CsvData {
  DateTime date;
  double ratio;

  CsvData(this.date, this.ratio);
}

class CsvParser {
  List<CsvData> parseCsv(String rawCsv) {
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(rawCsv);
    List<CsvData> data = [];
    // print(rowsAsListOfValues);
    for (var row in rowsAsListOfValues) {
      if (row.length == 9 &&
          row[8] != 'LOW IN VOLTAGE!' &&
          row[7] is num &&
          row[7] > 0.0 &&
          row[0] is String &&
          row[1] is String) {
        try {
          // print(row[0] + ' ' + row[1]);
          String dateStr = row[0];
          String timeStr = row[1];
          DateTime date = _parseDate(dateStr, timeStr);
          // print(date);
          // ratio of the reference sample to the corroded sample, mm
          double ratio = double.parse(row[7].toString());
          data.add(CsvData(date, ratio));
          // print(ratio);
        } catch (e) {
          // Ignoring erroneous line
          // print(e);
        }
      }
    }
    return data;
  }
}

DateTime _parseDate(String dateStr, String timeStr) {
  // Split the date into parts
  List<String> dateParts = dateStr.split('/');
  List<String> timeParts = timeStr.split(':');

  // Convert date parts to integers
  int year =
      int.parse('20' + dateParts[2]); // Assuming all dates are in the 2000s
  int month = int.parse(dateParts[1]);
  int day = int.parse(dateParts[0]);

  // Convert time parts to integers
  int hour = int.parse(timeParts[0].trim());
  int minute = int.parse(timeParts[1]);
  int second = timeParts.length > 2 ? int.parse(timeParts[2]) : 0;

  return DateTime(year, month, day, hour, minute, second);
}

class ExtendedCsvData {
  CsvData originalData;
  double metalLoss;

  ExtendedCsvData({required this.originalData, required this.metalLoss});
}
