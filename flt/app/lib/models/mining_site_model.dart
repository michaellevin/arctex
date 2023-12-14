import 'package:arktech/models/itree_node_model.dart';

class MiningSiteModel extends AbsPipelineModel {  
  MiningSiteModel({
    required String id,
    String? parentId,
    required String name,
    required TreeNodeType type,
  })  : super(id: id, parentId: parentId, name: name, type: type);

  static MiningSiteModel fromJson(Map<String, dynamic> json) {
    return MiningSiteModel(
      id: json['id'],
      parentId: json['parentId'],
      name: json['name'],
      type: TreeNodeType.miningSite,
    );
  }
}