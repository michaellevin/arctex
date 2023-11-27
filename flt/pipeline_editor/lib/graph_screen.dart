import 'package:flutter/material.dart';
import 'package:graph/widgets/pipeline_widget.dart';


class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {

  @override
  Widget build(BuildContext context) {
    return const PipelineWidget();
  }
}