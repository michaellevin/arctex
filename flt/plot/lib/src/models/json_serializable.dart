abstract class JsonSerializable {
  factory JsonSerializable.fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();

  Map<String, dynamic> toJson();
}
