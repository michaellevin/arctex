import 'dart:convert';
import 'package:arktech/bloc/pipeline_data_bloc.dart';
import 'package:arktech/models/itree_node_model.dart';
import 'package:arktech/models/mineral_site_model.dart';
import 'package:arktech/widgets/company_widget.dart';
import 'package:arktech/widgets/home_widget.dart';
import 'package:arktech/widgets/map_widget.dart';
import 'package:arktech/widgets/mineralsite_widget.dart';
import 'package:arktech/widgets/miningsite_widget.dart';
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
  TreeNodeType _selectedTreeNodeType = TreeNodeType.root;

  void _onTreeItemTap(ITreeNodeModel item) {
    setState(() {
      _selectedTreeNodeType = item.type;
    });
  }

  Widget _getSelectedWidget() {
    switch (_selectedTreeNodeType) {
      case TreeNodeType.root:
        return const HomeWidget();
      case TreeNodeType.company:
        return const CompanyWidget();
      case TreeNodeType.mineralSite:
        return const MineralSiteWidget();
      case TreeNodeType.miningSite:
        return const MiningSiteWidget();
      case TreeNodeType.pipeline:
        return const PipelineWidget();
      case TreeNodeType.pipesection:
        return const PipesectionWidget();
      default:
        return const Text('Unknown');
    }
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
            TreeWidget(state.pipelines, _onTreeItemTap),
            Expanded(
              flex: 1,
              child: _getSelectedWidget(),
            )
          ]
        );
      }
    );
  }
}