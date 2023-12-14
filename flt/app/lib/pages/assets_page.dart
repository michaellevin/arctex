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
  AbsPipelineModel? _selectedTreeNode;
  TreeWidget? _treeWidget;

  void _onTreeItemTap(AbsPipelineModel item) {
    setState(() {
      _selectedTreeNode = item;
    });
  }

  Widget _getSelectedWidget() {
    if (_selectedTreeNode == null) {
      return const HomeWidget();
    }

    var model = (context.read<PipelineDataBloc>().state as PipelineDataReadyState)
      .pipelines.where((element) => element.id == _selectedTreeNode!.id).first;

    print("Selected: ${model.name} (${model.id})");

    switch (_selectedTreeNode!.type) {
      case TreeNodeType.root:
        return const HomeWidget();
      case TreeNodeType.company:
        return const CompanyWidget();
      case TreeNodeType.mineralSite:
        return const MineralSiteWidget();
      case TreeNodeType.miningSite:
        return MiningSiteWidget(model as MiningSiteModel);
      case TreeNodeType.pipeline:
        return PipelineWidget(model as PipelineModel);
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

        _treeWidget ??= TreeWidget(state.pipelines, _onTreeItemTap);

        return Row(
          children: [
            _treeWidget!,
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