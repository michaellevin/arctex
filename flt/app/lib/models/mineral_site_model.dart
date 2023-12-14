import 'package:arktech/models/itree_node_model.dart';

class MineralSiteModel extends AbsPipelineModel {  
  MineralSiteModel({
    required String id,
    String? parentId,
    required String name,
    required TreeNodeType type,
  })  : super(id: id, parentId: parentId, name: name, type: type);

  static MineralSiteModel fromJson(Map<String, dynamic> json) {
    return MineralSiteModel(
      id: json['id'],
      parentId: json['parentId'],
      name: json['name'],
      type: TreeNodeType.mineralSite,
    );
  }
}