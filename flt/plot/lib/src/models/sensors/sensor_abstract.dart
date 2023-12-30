import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../../enums/enums_sensor.dart';
import '../json_serializable.dart';

typedef SensorFactory = Sensor Function(Map<String, dynamic> json);

// A Metaclass for all sensors
abstract class Sensor implements JsonSerializable {
  final String tag;
  final SensorType type;
  final DesignCorrosionRate designCorrosionRate;
  final DateTime dateProduction;
  final DateTime dateInstallation;
  SensorState state;
  DateTime dateNextService;
  String serviceComment;

  static final Map<SensorType, SensorFactory> _factories = {};

  static void registerFactory(SensorType type, SensorFactory factory) {
    _factories[type] = factory;
  }

  // Constructor
  Sensor({
    required this.tag,
    required this.type,
    DesignCorrosionRate? designCorrosionRate,
    DateTime? dateProduction,
    DateTime? dateInstallation,
    SensorState? state,
    DateTime? dateNextService,
    String? serviceComment,
  })  : dateProduction = dateProduction ?? DateTime.now(),
        dateInstallation = dateInstallation ?? DateTime.now(),
        designCorrosionRate = designCorrosionRate ?? DesignCorrosionRate.dcr_12,
        state = state ?? SensorState.ok,
        dateNextService = dateNextService ??
            DateTime.now().add(const Duration(days: 365 * 2)),
        serviceComment = serviceComment ?? '';

  // Read the sensor data from the JSON file
  static Sensor fromJson(Map<String, dynamic> json) {
    String stringCode = json['type'] as String;
    SensorType sensorType = SensorTypeExtension.fromCode(stringCode);
    var factory = _factories[sensorType];
    if (factory != null) {
      return factory(json);
    }
    throw Exception('Unknown sensor type: $stringCode');
  }
}

// load sensors from assets
Future<List<Sensor>> loadSensorsFromAssets(SensorType sensorType) async {
  String sensorsJsonPath = '';
  switch (sensorType) {
    case SensorType.er:
      sensorsJsonPath = 'assets/er_sensors.json';
    case SensorType.ut:
      sensorsJsonPath = 'assets/ut_sensors.json';
    case SensorType.cp:
      sensorsJsonPath = 'assets/cp_sensors.json';
    default:
      sensorsJsonPath = 'assets/er_sensors.json';
  }
  String jsonString = await rootBundle.loadString(sensorsJsonPath);
  List<dynamic> jsonResponse = json.decode(jsonString);
  return jsonResponse.map<Sensor>((json) => Sensor.fromJson(json)).toList();
}
