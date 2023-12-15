import 'package:arktech/models/itree_node_model.dart';
import 'package:arktech/models/parameter_model.dart';

class PipelineModel extends AbsPipelineModel {
  bool pigging, cathodicProtection, externalCoating;
  String cpType, environment, pipelineDesignCode;
  double length, designCorrosionRate, designTemperature, designPressure, designFlow;
  DateTime startDate;

  PipelineModel({
    required String id,
    String? parentId,
    required String name,
    required TreeNodeType type,

    required this.length,
    required this.environment,
    required this.pigging,
    required this.cathodicProtection,
    required this.externalCoating,
    required this.cpType,
    required this.pipelineDesignCode,
    required this.designCorrosionRate,
    required this.designTemperature,
    required this.designPressure,
    required this.designFlow,
    required this.startDate,    
  })  : super(id: id, parentId: parentId, name: name, type: type);
        

  static PipelineModel fromJson(Map<String, dynamic> json) {
    return PipelineModel(
      id: json['id'],
      parentId: json['parentId'],
      name: json['name'],
      type: TreeNodeType.pipeline,

      length: json['length'] ?? 0.0,
      environment: json['environment'] ?? '',
      pigging: json['pigging'] ?? false,
      cathodicProtection: json['cathodicProtection'] ?? false,
      externalCoating: json['externalCoating'] ?? false,
      cpType: json['cpType'] ?? '',
      pipelineDesignCode: json['pipelineDesignCode'] ?? '',
      designCorrosionRate: json['designCorrosionRate'] ?? 0.0,
      designTemperature: json['designTemperature'] ?? 0.0,
      designPressure: json['designPressure'] ?? 0.0,
      designFlow: json['designFlow'] ?? 0.0,
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : DateTime.utc(1969),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parentId': parentId,
      'name': name,
      'type': type.toString(),

      'length': length,
      'environment': environment,
      'pigging': pigging,
      'cathodicProtection': cathodicProtection,
      'externalCoating': externalCoating,
      'cpType': cpType,
      'pipelineDesignCode': pipelineDesignCode,
      'designCorrosionRate': designCorrosionRate,
      'designTemperature': designTemperature,
      'designPressure': designPressure,
      'designFlow': designFlow,
      'startDate': startDate.toIso8601String(),
    };
  }

  ParameterModel getParameter(int code) {
    switch(code) {
      case 1: return ParameterModel(name: "Наименование трубопровода", value: name, type: PPParamType.string);
      case 2: return ParameterModel(name: "Тип прокладки трубопровод", value: cpType, type: PPParamType.string);
      case 3: return ParameterModel(name: "Трубопровод пригоден для проведения внутритрубной диагностики?", value: pigging, type: PPParamType.bool);
      case 4: return ParameterModel(name: "Наличие ЭХЗ", value: cathodicProtection, type: PPParamType.bool);
      case 5: return ParameterModel(name: "Тип ЭХЗ", value: cpType, type: PPParamType.string);
      case 6: return ParameterModel(name: "Стандарт проектирования трубопровода", value: pipelineDesignCode, type: PPParamType.string);
      case 7: return ParameterModel(name: "Наличие наружной изоляции", value: externalCoating, type: PPParamType.bool);
      case 8: return ParameterModel(name: "Скорость коррозии проектная", value: designCorrosionRate, type: PPParamType.double, unit: "мм/г");
      case 9: return ParameterModel(name: "Скорость коррозии фактическая", value: 0, type: PPParamType.double, unit: "мм/г");
      case 10: return ParameterModel(name: "Дата ввода в эксплуатацию", value: startDate, type: PPParamType.string);
      case 11: return ParameterModel(name: "Температура проектная", value: designTemperature, type: PPParamType.double, unit: "°C");
      case 12: return ParameterModel(name: "Температура рабочая", value: 0, type: PPParamType.double, unit: "°C");
      case 13: return ParameterModel(name: "Давление проектное", value: designPressure, type: PPParamType.double, unit: "MPa");
      case 14: return ParameterModel(name: "Давление рабочее", value: 0, type: PPParamType.double, unit: "MPa");
      case 15: return ParameterModel(name: "Расход проектный", value: designFlow, type: PPParamType.double, unit: "м\u00B3/с");
      case 16: return ParameterModel(name: "Расход рабочий", value: 0, type: PPParamType.double, unit: "м\u00B3/с");
      case 17: return ParameterModel(name: "Длина", value: length, type: PPParamType.double, unit: "км");
      default: return ParameterModel(name: "Unknown", value: "Unknown", type: PPParamType.double);
    }
  }

  void setParameter(int code, dynamic value) {
    switch(code) {
      case 1: name = value; break;
      case 2: cpType = value; break;
      case 3: pigging = value; break;
      case 4: cathodicProtection = value; break;
      case 5: cpType = value; break;
      case 6: pipelineDesignCode = value; break;
      case 7: externalCoating = value; break;
      case 8: designCorrosionRate = double.parse(value); break;
      case 9: break;
      case 10: startDate = value; break;
      case 11: designTemperature = double.parse(value); break;
      case 12: break;
      case 13: designPressure = double.parse(value); break;
      case 14: break;
      case 15: designFlow = double.parse(value); break;
      case 16: break;
      case 17: length = double.parse(value); break;
      default: break;
    }
  }
}