enum TreeNodeType {
  root,
  company,
  mineralSite,
  miningSite,
  pipeline,
  pipesection,
}

class Entity {
  String id;
  String? parentId; // "?"" means nullable
  String name;
  TreeNodeType type;

  Entity({
    required this.id,
    required this.name,
    required this.type,
    this.parentId,
  });
}
