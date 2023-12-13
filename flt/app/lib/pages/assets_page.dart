import 'dart:convert';
import 'package:arktech/bloc/pipeline_data_bloc.dart';
import 'package:arktech/widgets/map_widget.dart';
import 'package:arktech/widgets/sensor_graph_widget.dart';
import 'package:arktech/widgets/tree_widget.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}


class _AssetsPageState extends State<AssetsPage> {
  final GlobalKey<MapWidgetState> _mapKey = GlobalKey();

  // void getCompData() async {
  //   var compData = await rootBundle.loadString('assets/companies.json');
  //   var compRaw = jsonDecode(compData);
  //   setState(() {
  //     _pipelines = compRaw["companies"]; 
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getCompData();
  // }

  void onSelect(Map<String, String> nodeData) {
    // print("selected: $nodeData");

    // List<Map<String, dynamic>> mrks = [];
    // var filtComps = _pipelines.where((element) => element["Owner"] == nodeData["title"]);
    // for (var i in filtComps) {
    //   if (i["Longitude"] == "" || i["Latitude"] == "") {
    //     continue;
    //   }
    //   mrks.add({
    //     "name": i["Unit name"],
    //     "long": i["Longitude"],
    //     "lat": i["Latitude"],
    //   });
    // }
    // print("Markers count: ${mrks.length}");
    // _mapKey.currentState!.doSomething(mrks);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PipelineDataBloc, PipelineDataState>(
      builder: (context, state) {
        if (state is! PipelineDataReadyState) {
          return const Center(child: CircularProgressIndicator());
        }

        return Row(
          children: [
            Expanded(
              flex: 1,
              child: TreeWidget(state.pipelines)
            ),
            Expanded(
              flex: 3,
              // child: MapWidget(key: _mapKey)
              child: SensorDataWidget(),
            )
          ]
        );
      }
    );
  }
}