import 'dart:convert';
import 'package:arktech/bloc/pipeline_data_bloc.dart';
import 'package:arktech/models/itree_node_model.dart';
import 'package:arktech/models/mineral_site_model.dart';
import 'package:arktech/models/mining_site_model.dart';
import 'package:arktech/models/pipeline_model.dart';
import 'package:arktech/widgets/company_widget.dart';
import 'package:arktech/widgets/home_widget.dart';
import 'package:arktech/widgets/map_widget.dart';
import 'package:arktech/widgets/mineralsite_widget.dart';
import 'package:arktech/widgets/miningsite_widget.dart';
import 'package:arktech/widgets/model_hub_widget.dart';
import 'package:arktech/widgets/pipeline_widget.dart';
import 'package:arktech/widgets/pipesection_widget.dart';
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

  void _onTreeItemTap(AbsPipelineModel item) {

  }

  void _onPipelineCreated(AbsPipelineModel? item) {

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TreeWidget(_onTreeItemTap, _onPipelineCreated),
        const Expanded(
          flex: 1,
          child: ModelHubWidget(),
        )
      ]
    );
  }
}