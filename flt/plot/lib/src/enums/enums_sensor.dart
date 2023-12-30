// Type of the Sensor
enum SensorType { er, ut, cp }

extension SensorTypeExtension on SensorType {
  static SensorType fromCode(String code) {
    switch (code) {
      case "0x01":
        return SensorType.er;
      case "0x02":
        return SensorType.ut;
      case "0x03":
        return SensorType.cp;
      default:
        return SensorType.er; // Default case
    }
  }

  String get displayString {
    switch (this) {
      case SensorType.er:
        return "Electric Resistance";
      case SensorType.ut:
        return "Ultrasonic Thickness";
      case SensorType.cp:
        return "Coupon Potential";
      default:
        return "Unknown";
    }
  }
}

// Design Corrosion Rate - Проектная скорость коррозии
enum DesignCorrosionRate {
  dcr_12(0.12),
  dcr_24(0.24);

  final double value;
  const DesignCorrosionRate(this.value);
}

extension DesignCorrosionRateExtension on DesignCorrosionRate {
  static DesignCorrosionRate fromCode(String code) {
    switch (code) {
      case "0x01":
        return DesignCorrosionRate.dcr_12; // 0.12 mm/year
      case "0x02":
        return DesignCorrosionRate.dcr_24; // 0.24 mm/year
      default:
        return DesignCorrosionRate.dcr_12;
    }
  }

  String get displayString => "$value mm/year";
}

// State of the sensor - Состояние датчика
enum SensorState { ok, dirty, broken }

extension SensorStateExtension on SensorState {
  static SensorState fromCode(String code) {
    switch (code) {
      case "0x01":
        return SensorState.ok;
      case "0x02":
        return SensorState.dirty;
      case "0x03":
        return SensorState.broken;
      default:
        return SensorState.ok;
    }
  }

  String get displayString {
    switch (this) {
      case SensorState.ok:
        return "Датчик исправен";
      case SensorState.dirty:
        return "Необходимо провести очистку от загрязнений/обезжиривание";
      case SensorState.broken:
        return "Требуется замена чувствительного элемента";
      default:
        return "Датчик исправен";
    }
  }
}
