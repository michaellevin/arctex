

class SensorDataModel {
  DateTime date;
  double thickness;
  double temperature;

  SensorDataModel({required this.date, required this.thickness, required this.temperature});

  factory SensorDataModel.fromJson(Map<String, dynamic> json) {
    return SensorDataModel(
      date: DateTime.parse(json['date']),
      thickness: json['thickness'],
      temperature: json['temperature'],
    );
  }
}