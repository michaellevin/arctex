import 'dart:convert';
import 'dart:io';

import 'package:arctex/models/company_model.dart';
import 'package:arctex/models/itree_node_model.dart';
import 'package:arctex/models/mineral_site_model.dart';
import 'package:arctex/models/mining_site_model.dart';
import 'package:arctex/models/pipeline_model.dart';
import 'package:arctex/models/pipesection_model.dart';
import 'package:path_provider/path_provider.dart';

String defaultData = '''
{
  "companies": [
    {
      "name": "Газпром Добыча Уренгой",
      "id": "company1"
    }
  ],
  "mineral_sites": [
    {
      "name": "Уренгойское месторождение",
      "id": "mineral_site1",
      "parentId": "company1",
      "type": "digging",
      "geo": {
        "lat": 66.5,
        "lon": 76.5
      }
    }
  ],
  "mining_sites": [
    {
      "name": "Газовый промысел 1",
      "id": "mining_site1",
      "parentId": "mineral_site1"
    }
  ],
  "pipelines": [
  ],
  "pipesections": [
  ]
}
''';

class PipelineDataProvider {
  static Future<List<Entity>> readData() async {
    var docDir = await getApplicationDocumentsDirectory();
    var appDataDir = Directory("${docDir.path}/Arctex");
    var exists = await appDataDir.exists();
    if (!exists) {
      print(
          "Application pipeline data directory not found. Creating new one at ${appDataDir.path}");
      appDataDir = await Directory(appDataDir.path).create();
      print("Created pipeline data directory: ${appDataDir.path}");
    }

    var filePath = '${appDataDir.absolute}/pipelines.json'
        .replaceAll(r'\', '/')
        .replaceAll(r"'", "")
        .replaceAll("Directory: ", "");
    var dataFile = File(filePath);
    exists = await dataFile.exists();
    if (!exists) {
      print("Pipeline data file not found. Creating new one at $filePath");
      dataFile = await File(filePath).create();
      print("Created pipeline data file: $filePath");
      await dataFile.writeAsString(defaultData);
    }

    print("Reading pipeline data from $filePath");

    var data = await dataFile.readAsString();
    var pipelines = <Entity>[];
    var rawData = jsonDecode(data);

    for (var p in rawData["companies"]) {
      pipelines.add(CompanyModel.fromJson(p));
    }
    for (var p in rawData["mineral_sites"]) {
      pipelines.add(MineralSiteModel.fromJson(p));
    }
    for (var p in rawData["mining_sites"]) {
      pipelines.add(MiningSiteModel.fromJson(p));
    }
    for (var p in rawData["pipelines"]) {
      pipelines.add(PipelineModel.fromJson(p));
    }
    for (var p in rawData["pipesections"]) {
      pipelines.add(PipesectionModel.fromJson(p));
    }

    return pipelines;
  }

  static Future<void> addModel(Entity model) async {
    var docDir = await getApplicationDocumentsDirectory();
    var appDataDir = Directory("${docDir.path}/Arctex");
    var filePath = '${appDataDir.absolute}/pipelines.json'
        .replaceAll(r'\', '/')
        .replaceAll(r"'", "")
        .replaceAll("Directory: ", "");
    var dataFile = File(filePath);
    var data = await dataFile.readAsString();
    var rawData = jsonDecode(data);

    if (model is PipelineModel) {
      var index = rawData["pipelines"].indexWhere((e) => e["id"] == model.id);
      if (index == -1) {
        rawData["pipelines"].add(model.toJson());
      } else {
        rawData["pipelines"][index] = model.toJson();
      }
    }
    if (model is PipesectionModel) {
      var index =
          rawData["pipesections"].indexWhere((e) => e["id"] == model.id);
      if (index == -1) {
        rawData["pipesections"].add(model.toJson());
      } else {
        rawData["pipesections"][index] = model.toJson();
      }
    }
    print(rawData);
    await dataFile.writeAsString(jsonEncode(rawData));
  }
}
