import 'package:arktech/models/itree_node_model.dart';

class PipelineModel extends AbsPipelineModel {
  PipelineModel({
    required String id,
    String? parentId,
    required String name,
    required TreeNodeType type,
  })  : super(id: id, parentId: parentId, name: name, type: type);

  static PipelineModel fromJson(Map<String, dynamic> json) {
    return PipelineModel(
      id: json['id'],
      parentId: json['parentId'],
      name: json['name'],
      type: TreeNodeType.pipeline,
    );
  }
}