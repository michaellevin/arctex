import 'dart:convert';
import 'dart:io';

import 'package:arctex/models/sensor_model.dart';
import 'package:path_provider/path_provider.dart';

class SensorDataProvider {
  static Future<List<SensorDataModel>> readData(String sensorId) async {
    var docDir = await getApplicationDocumentsDirectory();
    var file = File("${docDir.path}/Arctex/Sensors/$sensorId.json");
    var exists = await file.exists();
    if (!exists) {
      print("Sensor data file not found at ${file.path}");
      return [];
    }
    var data = await file.readAsString();
    var sensors = <SensorDataModel>[];
    var rawData = jsonDecode(data);
    for (var pair in rawData[sensorId.toString()].entries) {
      sensors.add(SensorDataModel.fromJson({
        "date": pair.key,
        "thickness": pair.value["thickness"],
        "temperature": pair.value["temperature"],
      }));
    }
    return sensors;
  }
}
