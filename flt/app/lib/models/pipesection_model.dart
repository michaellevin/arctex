import 'package:arktech/models/itree_node_model.dart';

class PipesectionModel extends ITreeNodeModel {
  PipesectionModel({
    required String id,
    String? parentId,
    required String name,
    required TreeNodeType type,
  })  : super(id: id, parentId: parentId, name: name, type: type);

  static PipesectionModel fromJson(Map<String, dynamic> json) {
    return PipesectionModel(
      id: json['id'],
      parentId: json['parentId'],
      name: json['name'],
      type: TreeNodeType.pipesection,
    );
  }
}