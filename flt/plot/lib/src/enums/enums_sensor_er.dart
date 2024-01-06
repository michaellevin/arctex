import '../utils/helpers.dart';

// Type of the ER sensor - Тип датчика ЭДС
enum ErType {
  smallEnd(0x01),
  largeEnd(0x02),
  cylindrical(0x03),
  wireLoop(0x04),
  tubularLoop(0x05),
  stripLoop(0x06);

  final int value;
  const ErType(this.value);
}

extension ErTypeExtension on ErType {
  static ErType fromCode(String code) {
    switch (parseHex(code)) {
      case 0x01:
        return ErType.smallEnd;
      case 0x02:
        return ErType.largeEnd;
      case 0x03:
        return ErType.cylindrical;
      case 0x04:
        return ErType.wireLoop;
      case 0x05:
        return ErType.tubularLoop;
      case 0x06:
        return ErType.stripLoop;
      default:
        return ErType.smallEnd; // Default case
    }
  }

  String get displayString {
    switch (this) {
      case ErType.smallEnd:
        return "Торцевой малый";
      case ErType.largeEnd:
        return "Торцевой большой";
      case ErType.cylindrical:
        return "Цилиндрический";
      case ErType.wireLoop:
        return "Петлевой проволочный";
      case ErType.tubularLoop:
        return "Петлевой трубчатый";
      case ErType.stripLoop:
        return "Петлевой ленточный";
      default:
        return "Торцевой малый";
    }
  }
}

// Inner diameter of the ER sensor - Внутренний диаметр датчика
enum InnerDiameter {
  diameter8(8.0),
  diameter9(9.0);

  final double value;
  const InnerDiameter(this.value);
}

extension InnerDiameterExtension on InnerDiameter {
  static InnerDiameter fromCode(String code) {
    switch (parseHex(code)) {
      case 0x01:
        return InnerDiameter.diameter8;
      case 0x02:
        return InnerDiameter.diameter9;
      default:
        return InnerDiameter.diameter8; // Default or error value
    }
  }

  int get code {
    switch (this) {
      case InnerDiameter.diameter8:
        return 0x01;
      case InnerDiameter.diameter9:
        return 0x02;
      default:
        return 0x01; // Default case
    }
  }

  String get displayString => "$value mm";
}

// Reference sample area of the ER sensor - Площадь эталонного образца
enum ReferenceSampleArea {
  area_53_41(53.41),
  area_52_00(52.0);

  final double value;
  const ReferenceSampleArea(this.value);
}

extension ReferenceSampleAreaExtension on ReferenceSampleArea {
  static ReferenceSampleArea fromCode(String code) {
    switch (parseHex(code)) {
      case 0x01:
        return ReferenceSampleArea.area_53_41;
      case 0x02:
        return ReferenceSampleArea.area_52_00;
      default:
        return ReferenceSampleArea.area_53_41;
    }
  }

  int get code {
    switch (this) {
      case ReferenceSampleArea.area_53_41:
        return 0x01;
      case ReferenceSampleArea.area_52_00:
        return 0x02;
      default:
        return 0x01; // Default case
    }
  }

  String get displayString => "$value mm\u00B2";
}
