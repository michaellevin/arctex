import 'dart:convert';
import 'dart:io';

import 'package:arktech/models/company_model.dart';
import 'package:arktech/models/itree_node_model.dart';
import 'package:arktech/models/mineral_site_model.dart';
import 'package:arktech/models/mining_site_model.dart';
import 'package:arktech/models/pipeline_model.dart';
import 'package:arktech/models/pipesection_model.dart';
import 'package:path_provider/path_provider.dart';

class PipelineDataProvider {
  static Future<List<ITreeNodeModel>> readData() async {
    var docDir = await getApplicationDocumentsDirectory();
    var appDataDir = Directory("${docDir.path}/Arctex");
    var exists = await appDataDir.exists();
    if (!exists) {
      print("Application pipeline data directory not found. Creating new one at ${appDataDir.path}");
      appDataDir = await Directory(appDataDir.path).create();
      print("Created pipeline data directory: ${appDataDir.path}");
    }

    var filePath = '${appDataDir.absolute}/pipelines.json'.replaceAll(r'\', '/').replaceAll(r"'", "").replaceAll("Directory: ", "");
    var dataFile = File(filePath);
    exists = await dataFile.exists();
    if (!exists) {
      print("Pipeline data file not found. Creating new one at $filePath");
      dataFile = await File(filePath).create();
      print("Created pipeline data file: $filePath");
      await dataFile.writeAsString("{\"pipelines\": []}");
    }
    
    print("Reading pipeline data from $filePath");

    var data = await dataFile.readAsString();
    var pipelines = <ITreeNodeModel>[];
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
}