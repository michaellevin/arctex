import 'package:arctex/models/itree_node_model.dart';
import 'package:arctex/models/parameter_model.dart';

enum PipelineParameterCode {
  pipelineName, // Наименование трубопровода [string]
  pipelineDesignStandard, // Стандарт проектирования трубопровода [string]
  designCorrosionTolerance, // Проектный допуск на коррозию [double] mm (мм)
  designLifeOfEquipment, // Проектный срок службы оборудования [int] years (лет)
  designCorrosionRate, // Проектная скорость коррозии [double] mm/year (мм/г)
  workingCorrosionRate, // Фактическая скорость коррозии [double] mm/year (мм/г)
  startDate, // Дата ввода в эксплуатацию [date] YYYY-MM-DD (ГГГГ-ММ-ДД)
  designTemperature, // Проектная температура [double] °C (градусы Цельсия)
  workingTemperature, // Рабочая температура [double] °C (градусы Цельсия)
  designPressure, // Проектное давление [double] MPa (МПа)
  workingPressure, // Рабочее давление [double] MPa (МПа)
  length, // Длина трубопровода [double] m (м)

  pipeworkMaterial, // Материал трубопровода [string]
  materialStandard, // Стандарт материала [string]
  nominalWallThickness, // Номинальная толщина стенки [double] mm (мм)
  minPermissibleWallThickness, // Минимально допустимая толщина стенки [double] mm (мм)
  actualWallThickness, // Фактическая толщина стенки [double] mm (мм)
  outerDiameter, // Наружный диаметр [double] mm (мм)
}

class PipelineModel extends Entity {
  String pipelineDesignStandard, pipeworkMaterial, materialStandard;
  int designLifeOfEquipment, designTemperature;
  double length, designCorrosionTolerance, designCorrosionRate, designPressure;
  double nominalWallThickness, minPermissibleWallThickness, outerDiameter;
  DateTime startDate;

  // to be calculated
  double workingCorrosionRate = 0.0,
      workingPressure = 0.0,
      actualWallThickness = 0.0;
  int workingTemperature = 0;

  PipelineModel({
    required String id,
    String? parentId,
    required String name,
    required TreeNodeType type,
    required this.length,
    required this.pipelineDesignStandard,
    required this.designCorrosionTolerance,
    required this.designLifeOfEquipment,
    required this.designCorrosionRate,
    required this.designTemperature,
    required this.designPressure,
    required this.startDate,
    required this.pipeworkMaterial,
    required this.materialStandard,
    required this.nominalWallThickness,
    required this.minPermissibleWallThickness,
    required this.outerDiameter,
    this.workingCorrosionRate = 0.0,
    this.workingTemperature = 0,
    this.workingPressure = 0.0,
    this.actualWallThickness = 0.0,
  }) : super(id: id, parentId: parentId, name: name, type: type);

  static PipelineModel fromJson(Map<String, dynamic> json) {
    return PipelineModel(
      id: json['id'],
      parentId: json['parentId'],
      name: json['name'],
      type: TreeNodeType.pipeline,
      length: json['length'] ?? 10000,
      pipelineDesignStandard:
          json['pipelineDesignStandard'] ?? "ГОСТ Р 55990-2014",
      designCorrosionTolerance: json['designCorrosionTolerance'] ?? 3.0,
      designLifeOfEquipment: json['designLifeOfEquipment'] ?? 30,
      designCorrosionRate: json['designCorrosionRate'] ?? 0.1,
      designTemperature: json['designTemperature'] ?? 60,
      designPressure: json['designPressure'] ?? 10.0,
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : DateTime.utc(2023, 1, 1),
      pipeworkMaterial: json['pipeworkMaterial'] ?? "Сталь 09Г2С",
      materialStandard: json['materialStandard'] ?? "ГОСТ 19281-89",
      nominalWallThickness: json['nominalWallThickness'] ?? 10.0,
      minPermissibleWallThickness: json['minPermissibleWallThickness'] ?? 3.0,
      outerDiameter: json['outerDiameter'] ?? 165.0,

      // to be calculated
      workingCorrosionRate: json['workingCorrosionRate'] ?? 0.0,
      workingTemperature: json['workingTemperature'] ?? 0,
      workingPressure: json['workingPressure'] ?? 0.0,
      actualWallThickness: json['actualWallThickness'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parentId': parentId,
      'name': name,
      'type': type.toString(),
      'length': length,
      'pipelineDesignStandard': pipelineDesignStandard,
      'designCorrosionTolerance': designCorrosionTolerance,
      'designLifeOfEquipment': designLifeOfEquipment,
      'designCorrosionRate': designCorrosionRate,
      'designTemperature': designTemperature,
      'designPressure': designPressure,
      'startDate': startDate.toIso8601String(),
      'pipeworkMaterial': pipeworkMaterial,
      'materialStandard': materialStandard,
      'nominalWallThickness': nominalWallThickness,
      'minPermissibleWallThickness': minPermissibleWallThickness,
      'outerDiameter': outerDiameter,

      // to be calculated
      'workingCorrosionRate': workingCorrosionRate,
      'workingTemperature': workingTemperature,
      'workingPressure': workingPressure,
      'actualWallThickness': actualWallThickness,
    };
  }

  ParameterModel getParameter(PipelineParameterCode code) {
    switch (code) {
      case PipelineParameterCode.pipelineName:
        return ParameterModel(
          name: "Наименование трубопровода",
          value: name,
          type: PPParamType.string,
        );
      case PipelineParameterCode.pipelineDesignStandard:
        return ParameterModel(
          name: "Стандарт проектирования трубопровода",
          value: pipelineDesignStandard,
          type: PPParamType.string,
        );
      case PipelineParameterCode.designCorrosionTolerance:
        return ParameterModel(
          name: "Проектный допуск на коррозию",
          value: designCorrosionTolerance,
          type: PPParamType.double,
          unit: "mm",
        );
      case PipelineParameterCode.designLifeOfEquipment:
        return ParameterModel(
          name: "Проектный срок службы оборудования",
          value: designLifeOfEquipment,
          type: PPParamType.int,
          unit: "years",
        );
      case PipelineParameterCode.designCorrosionRate:
        return ParameterModel(
          name: "Проектная скорость коррозии",
          value: designCorrosionRate,
          type: PPParamType.double,
          unit: "mm/year",
        );
      case PipelineParameterCode.workingCorrosionRate:
        return ParameterModel(
          name: "Фактическая скорость коррозии",
          value: workingCorrosionRate,
          type: PPParamType.double,
          unit: "mm/year",
        );
      case PipelineParameterCode.startDate:
        return ParameterModel(
          name: "Дата ввода в эксплуатацию",
          value: startDate,
          type: PPParamType.date,
        );
      case PipelineParameterCode.designTemperature:
        return ParameterModel(
          name: "Проектная температура",
          value: designTemperature,
          type: PPParamType.int,
          unit: "°C",
        );
      case PipelineParameterCode.workingTemperature:
        return ParameterModel(
          name: "Рабочая температура",
          value: workingTemperature,
          type: PPParamType.int,
          unit: "°C",
        );
      case PipelineParameterCode.designPressure:
        return ParameterModel(
          name: "Проектное давление",
          value: designPressure,
          type: PPParamType.double,
          unit: "MPa",
        );
      case PipelineParameterCode.workingPressure:
        return ParameterModel(
          name: "Рабочее давление",
          value: workingPressure,
          type: PPParamType.double,
          unit: "MPa",
        );
      case PipelineParameterCode.length:
        return ParameterModel(
          name: "Длина трубопровода",
          value: length,
          type: PPParamType.double,
          unit: "m",
        );
      case PipelineParameterCode.pipeworkMaterial:
        return ParameterModel(
          name: "Материал трубопровода",
          value: pipeworkMaterial,
          type: PPParamType.string,
        );
      case PipelineParameterCode.materialStandard:
        return ParameterModel(
          name: "Стандарт материала",
          value: materialStandard,
          type: PPParamType.string,
        );
      case PipelineParameterCode.nominalWallThickness:
        return ParameterModel(
          name: "Номинальная толщина стенки",
          value: nominalWallThickness,
          type: PPParamType.double,
          unit: "mm",
        );
      case PipelineParameterCode.minPermissibleWallThickness:
        return ParameterModel(
          name: "Минимально допустимая толщина стенки",
          value: minPermissibleWallThickness,
          type: PPParamType.double,
          unit: "mm",
        );
      case PipelineParameterCode.actualWallThickness:
        return ParameterModel(
          name: "Фактическая толщина стенки",
          value: actualWallThickness,
          type: PPParamType.double,
          unit: "mm",
        );
      case PipelineParameterCode.outerDiameter:
        return ParameterModel(
          name: "Наружный диаметр",
          value: outerDiameter,
          type: PPParamType.double,
          unit: "mm",
        );
      default:
        return ParameterModel(
          name: "Unknown",
          value: "Unknown",
          type: PPParamType.string,
        );
    }
  }

  void setParameter(PipelineParameterCode code, dynamic value) {
    switch (code) {
      case PipelineParameterCode.pipelineName:
        name = value.toString();
        break;
      case PipelineParameterCode.pipelineDesignStandard:
        pipelineDesignStandard = value.toString();
        break;
      case PipelineParameterCode.designCorrosionTolerance:
        designCorrosionTolerance = double.parse(value);
        break;
      case PipelineParameterCode.designLifeOfEquipment:
        designLifeOfEquipment = int.parse(value);
        break;
      case PipelineParameterCode.designCorrosionRate:
        designCorrosionRate = double.parse(value);
        break;
      case PipelineParameterCode.workingCorrosionRate:
        workingCorrosionRate = double.parse(value);
        break;
      case PipelineParameterCode.startDate:
        startDate = DateTime.parse(value);
        break;
      case PipelineParameterCode.designTemperature:
        designTemperature = int.parse(value);
        break;
      case PipelineParameterCode.workingTemperature:
        workingTemperature = int.parse(value);
        break;
      case PipelineParameterCode.designPressure:
        designPressure = double.parse(value);
        break;
      case PipelineParameterCode.workingPressure:
        workingPressure = double.parse(value);
        break;
      case PipelineParameterCode.length:
        length = double.parse(value);
        break;
      case PipelineParameterCode.pipeworkMaterial:
        pipeworkMaterial = value.toString();
        break;
      case PipelineParameterCode.materialStandard:
        materialStandard = value.toString();
        break;
      case PipelineParameterCode.nominalWallThickness:
        nominalWallThickness = double.parse(value);
        break;
      case PipelineParameterCode.minPermissibleWallThickness:
        minPermissibleWallThickness = double.parse(value);
        break;
      case PipelineParameterCode.actualWallThickness:
        actualWallThickness = double.parse(value);
        break;
      case PipelineParameterCode.outerDiameter:
        outerDiameter = double.parse(value);
        break;
      default:
        break;
    }
  }
}
