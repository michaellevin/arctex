
enum TreeNodeType {
  root,
  company,
  mineralSite,
  miningSite,
  pipeline,
  pipesection,
}

class AbsPipelineModel {
  String id;
  String? parentId;
  String name;
  TreeNodeType type;

  AbsPipelineModel({
    required this.id,
    required this.name,
    required this.type,
    this.parentId,
  });
}