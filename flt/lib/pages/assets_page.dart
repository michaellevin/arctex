import 'package:arktech/database/database_connector.dart';
import 'package:arktech/widgets/map_widget.dart';
import 'package:arktech/widgets/tree_widget.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';


class AssetsPage extends StatefulWidget {
  final DatabaseConnector dbConnector;

  const AssetsPage(this.dbConnector, {super.key});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}


class _AssetsPageState extends State<AssetsPage> {
  late Results _companies;

  final GlobalKey<MapWidgetState> _mapKey = GlobalKey();

  void getCompData() async {
    // var compData = await rootBundle.loadString('assets/companies.json');
    // var compRaw = jsonDecode(compData);
    // setState(() {
    //   _companies = compRaw["companies"];      
    // });
    _companies = await widget.dbConnector.getCompanies();
    print(_companies);
  }

  @override
  void initState() {
    super.initState();
    getCompData();
  }

  void onSelect(Map<String, String> nodeData) {
    List<Map<String, dynamic>> mrks = [];
    var filtComps = _companies.where((element) => element["Owner"] == nodeData["title"]);
    for (var i in filtComps) {
      if (i["Longitude"] == "" || i["Latitude"] == "") {
        continue;
      }
      mrks.add({
        "name": i["Unit name"],
        "long": i["Longitude"],
        "lat": i["Latitude"],
      });
    }
    
    _mapKey.currentState!.doSomething(mrks);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TreeWidget(_companies, onSelect),
        MapWidget(key: _mapKey),
      ],
    );
  }
}