// Electric Resistance (ER) sensor

import 'sensor_abstract.dart';
import '../../enums/enums_sensor.dart';
import '../../enums/enums_sensor_er.dart';

class ERSensor extends Sensor {
  final ErType erType;
  final ReferenceSampleArea referenceSampleArea;
  final InnerDiameter innerDiameter;
  final int designTemperature;

  late double longTermCorrosionRate;
  late double shortTermCorrosionRate;

  ERSensor({
    required String tag,
    required this.erType,
    required this.referenceSampleArea,
    required this.innerDiameter,
    int? designTemperature,
    DateTime? dateProduction,
    DateTime? dateInstallation,
    SensorState? state,
    DateTime? dateNextService,
    String? serviceComment,
    DesignCorrosionRate? designCorrosionRate,
    double? longTermCorrosionRate,
    double? shortTermCorrosionRate,
  })  : designTemperature =
            designTemperature ?? 20, // Default or a meaningful value
        super(
          tag: tag,
          type: SensorType.er,
          designCorrosionRate: designCorrosionRate,
          dateProduction: dateProduction,
          dateInstallation: dateInstallation,
          state: state,
          dateNextService: dateNextService ??
              DateTime.now().add(const Duration(days: 365 * 2)),
          serviceComment: serviceComment ?? '',
        );

  factory ERSensor.fromJson(Map<String, dynamic> json) {
    return ERSensor(
      tag: json['tag'] as String,
      erType: ErTypeExtension.fromCode(json['er_type'] as String),
      referenceSampleArea: ReferenceSampleAreaExtension.fromCode(
          json['reference_sample_area'] as String),
      innerDiameter:
          InnerDiameterExtension.fromCode(json['inner_diameter'] as String),
      designTemperature: json['design_temperature'] as int,
      dateProduction: json['date_production'] != null
          ? DateTime.parse(json['date_production'] as String)
          : null,
      dateInstallation: json['date_installation'] != null
          ? DateTime.parse(json['date_installation'] as String)
          : null,
      state: SensorStateExtension.fromCode(json['state'] as String),
      dateNextService: json['date_next_service'] != null
          ? DateTime.parse(json['date_next_service'] as String)
          : null,
      serviceComment: json['service_comment'] as String,
      designCorrosionRate: DesignCorrosionRateExtension.fromCode(
          json['design_corrosion_rate'] as String),
      longTermCorrosionRate: json['long_term_corrosion_rate'] as double,
      shortTermCorrosionRate: json['short_term_corrosion_rate'] as double,
    );
  }
}
