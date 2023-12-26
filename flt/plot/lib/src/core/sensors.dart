import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Sensor {
  final String tag;
  final String type;
  final DateTime dateProduction;
  final DateTime dateInstallation;
  final double projectCorrosionRate;
  late String state;
  late DateTime dateNextService;
  late String serviceComment;

  Sensor({
    required this.tag,
    required this.type,
    required this.dateProduction,
    required this.dateInstallation,
    required this.projectCorrosionRate,
    required this.state,
    required this.dateNextService,
    required this.serviceComment,
  });
}

class ERSensor extends Sensor {
  final String erType;
  final double longTermCorrosionRate;
  final double shortTermCorrosionRate;
  final double referenceSampleArea;
  final double innerDiameter;

  ERSensor({
    required String tag,
    required String type,
    required DateTime dateProduction,
    required DateTime dateInstallation,
    required double projectCorrosionRate,
    required String state,
    required DateTime dateNextService,
    required String serviceComment,
    required this.erType,
    required this.longTermCorrosionRate,
    required this.shortTermCorrosionRate,
    required this.referenceSampleArea,
    required this.innerDiameter,
  }) : super(
          tag: tag,
          type: type,
          dateProduction: dateProduction,
          dateInstallation: dateInstallation,
          projectCorrosionRate: projectCorrosionRate,
          state: state,
          dateNextService: dateNextService,
          serviceComment: serviceComment,
        );

  factory ERSensor.fromJson(Map<String, dynamic> json) {
    return ERSensor(
      tag: json['tag'],
      type: json['type'],
      dateProduction: DateTime.parse(json['date_production']),
      dateInstallation: DateTime.parse(json['date_installation']),
      projectCorrosionRate: json['project_corrosion_rate'].toDouble(),
      state: json['state'],
      dateNextService: DateTime.parse(json['date_next_service']),
      serviceComment: json['service_comment'],
      erType: json['er_type'],
      longTermCorrosionRate: json['long_term_corrosion_rate'].toDouble(),
      shortTermCorrosionRate: json['short_term_corrosion_rate'].toDouble(),
      referenceSampleArea: json['reference_sample_area'].toDouble(),
      innerDiameter: json['inner_diameter'].toDouble(),
    );
  }
}

Future<List<ERSensor>> loadERSensorsFromAssets() async {
  String jsonString = await rootBundle.loadString('assets/er_sensors.json');
  List<dynamic> jsonResponse = json.decode(jsonString);
  return jsonResponse.map<ERSensor>((json) => ERSensor.fromJson(json)).toList();
}
