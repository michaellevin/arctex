import 'package:flutter/material.dart';
import 'package:dxf/dxf.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:graph/widgets/pipeline_widget.dart';


class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  DXF? _dxf;

  // @override
  // void initState() {
  //   super.initState();
  //   readDxf();
  // }

  void readDxf() async {
    String dxfString = await rootBundle.loadString('assets/scheme.dxf');
    setState(() {
      _dxf = DXF.fromString(dxfString);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PipelineWidget();
  }
}