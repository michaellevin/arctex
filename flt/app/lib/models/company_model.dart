import 'package:arktech/models/itree_node_model.dart';

class CompanyModel extends ITreeNodeModel {  
  CompanyModel({
    required String id,
    String? parentId,
    required String name,
    required TreeNodeType type,
  })  : super(id: id, parentId: parentId, name: name, type: type);

  static CompanyModel fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'],
      parentId: json['parentId'],
      name: json['name'],
      type: TreeNodeType.company,
    );
  }
}