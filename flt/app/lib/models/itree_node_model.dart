
enum TreeNodeType {
  root,
  company,
  mineralSite,
  miningSite,
  pipeline,
  pipesection,
}

class ITreeNodeModel {
  String id;
  String? parentId;
  String name;
  TreeNodeType type;

  ITreeNodeModel({
    required this.id,
    required this.name,
    required this.type,
    this.parentId,
  });
}