import 'package:arctex/models/itree_node_model.dart';

class PipesectionModel extends Entity {
  PipesectionModel({
    required String id,
    String? parentId,
    required String name,
    required TreeNodeType type,
  }) : super(id: id, parentId: parentId, name: name, type: type);

  static PipesectionModel fromJson(Map<String, dynamic> json) {
    return PipesectionModel(
      id: json['id'],
      parentId: json['parentId'],
      name: json['name'],
      type: TreeNodeType.pipesection,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parentId': parentId,
      'name': name,
      'type': type.toString(),
    };
  }
}
