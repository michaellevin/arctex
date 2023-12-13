class PipelineModel {
  final String name;
  final String id;
  final String? parentId;

  PipelineModel({required this.name, required this.id, this.parentId});

  factory PipelineModel.fromJson(Map<String, dynamic> json) {
    return PipelineModel(
      name: json['name'],
      id: json['id'],
      parentId: json['parentId'],
    );
  }
}