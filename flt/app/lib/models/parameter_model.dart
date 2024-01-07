
enum PPParamType {
  string,
  int,
  double,
  bool,
  date,
  time,
  datetime,
  list,
}

class ParameterModel {
  String name;
  dynamic value;
  String? unit;
  PPParamType type;

  ParameterModel({required this.name, required this.value, required this.type, this.unit});
}