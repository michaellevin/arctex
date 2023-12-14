import 'package:arktech/models/itree_node_model.dart';

class PipelineModel extends AbsPipelineModel {
  bool pigging, cathodicProtection, externalCoating;
  String cpType, environment, pipelineDesignCode;
  double designCorrosionRate, designTemperature, designPressure, designFlow;
  DateTime startDate;

  PipelineModel({
    required String id,
    String? parentId,
    required String name,
    required TreeNodeType type,

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
}