import 'dart:convert';
import 'package:arctex/bloc/pipeline_data_bloc.dart';
import 'package:arctex/models/itree_node_model.dart';
import 'package:arctex/models/mineral_site_model.dart';
import 'package:arctex/models/mining_site_model.dart';
import 'package:arctex/models/pipeline_model.dart';
import 'package:arctex/widgets/company_widget.dart';
import 'package:arctex/widgets/home_widget.dart';
import 'package:arctex/widgets/map_widget.dart';
import 'package:arctex/widgets/mineralsite_widget.dart';
import 'package:arctex/widgets/miningsite_widget.dart';
import 'package:arctex/widgets/model_hub_widget.dart';
import 'package:arctex/widgets/pipeline_widget.dart';
import 'package:arctex/widgets/pipesection_widget.dart';
import 'package:arctex/widgets/sensor_graph_widget.dart';
import 'package:arctex/widgets/tree_widget.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  void _onTreeItemTap(Entity item) {}

  void _onPipelineCreated(Entity? item) {}

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      TreeWidget(_onTreeItemTap, _onPipelineCreated),
      const Expanded(
        flex: 1,
        child: ModelHubWidget(),
      )
    ]);
  }
}
