import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:arktech/bloc/pipeline_data_bloc.dart';
import 'package:arktech/bloc/sensor_data_bloc.dart';
import 'package:arktech/models/itree_node_model.dart';
import 'package:arktech/models/mining_site_model.dart';
import 'package:arktech/models/pipeline_model.dart';
import 'package:arktech/models/pipesection_model.dart';
import 'package:arktech/tools/misc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TreeWidget extends StatefulWidget {
  final Function(AbsPipelineModel item) _onItemTap;
  final Function(AbsPipelineModel? item) _onPipelineCreated;

  const TreeWidget(this._onItemTap, this._onPipelineCreated, {super.key});

  @override
  State<TreeWidget> createState() => _TreeWidgetState();
}

class _TreeWidgetState extends State<TreeWidget> {
  final TreeNode<AbsPipelineModel> _simpleTree = TreeNode.root(data: AbsPipelineModel(id: "root", name: "root", type: TreeNodeType.root));
  TreeNode? _selectedTreeNode;
  bool _createPipelineMode = false;

  @override
  void initState() {
    super.initState();
    buildTree();
  }

  void buildTree() {
    var blocState = context.read<PipelineDataBloc>().state;
    // if (blocState is! PipelineDataReadyState) {
    //   return;
    // }

    var pipelines = (blocState as PipelineDataReadyState).pipelines;
    var nodes = pipelines.map((e) => TreeNode(data: e)).toList();

    for (var n in nodes) {
      var parent = nodes.where((e) => e.data!.id == n.data!.parentId);
      if (parent.isEmpty) {
        continue;
      }
      parent.first.add(n);
    }

    for (var p in nodes) {
      if (p.data!.parentId == null) {
        _simpleTree.add(p);
      }
    }
  }

  void _onItemTap(TreeNode item) {
    setState(() {
      _selectedTreeNode = item;
    });
    widget._onItemTap(item.data!);
    context.read<PipelineDataBloc>().add(PipelineDataSelectEvent(item.data!));  
  }

  void _createPipeline() {
    if (_selectedTreeNode == null) {
      return;
    }

    AbsPipelineModel newPipelineModel;

    if (_selectedTreeNode!.data  is MiningSiteModel) {
      newPipelineModel = PipelineModel(
        id: getRandomPipelineId(),
        name: "New pipeline",
        parentId: _selectedTreeNode!.data.id,
        type: TreeNodeType.pipeline,
        length: 0.0,
        environment: "",
        pigging: false,
        cathodicProtection: false,
        externalCoating: false,
        cpType: "",
        pipelineDesignCode: "",
        designCorrosionRate: 0.0,
        designTemperature: 0.0,
        designPressure: 0.0,
        designFlow: 0.0,
        startDate: DateTime.now(),
      );
    }
    else if (_selectedTreeNode!.data is PipelineModel) {
      newPipelineModel = PipesectionModel(
        id: getRandomPipelineId(),
        name: "New pipesection",
        parentId: _selectedTreeNode!.data.id,
        type: TreeNodeType.pipesection,
      );
    }
    else {
      print("Unknown pipeline type");
      return;
    }

    _selectedTreeNode!.add(TreeNode(data: newPipelineModel));
    widget._onPipelineCreated(newPipelineModel);
    context.read<PipelineDataBloc>().add(PipelineDataAddEvent(newPipelineModel));

    setState(() {
      _createPipelineMode = true;
    });
  }

  String _getPipelineType() {
    if (_selectedTreeNode == null) {
      return "";
    }

    if (_selectedTreeNode!.data is MiningSiteModel) {
      return "Трубопровод";
    }
    if (_selectedTreeNode!.data is PipelineModel) {
      return "Участок";
    }
    if (_selectedTreeNode!.data is PipesectionModel) {
      return "Датчик";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PipelineDataBloc, PipelineDataState>(
      listener: (context, state) {
        if (state is PipelineCreatedState) {
          _createPipelineMode = false;
          widget._onPipelineCreated(null);
        }
      },
      builder: (context, state) {
        return Container(
          alignment: Alignment.topCenter,
          width: 300,
          child: Column(
            children: [
              Expanded(
                child: TreeView.simple(
                  tree: _simpleTree,
                  showRootNode: false,
                  onItemTap: _createPipelineMode ? null : _onItemTap,
                  builder: (context, node) {
                    return ListTile(
                      title: Text(node.data!.name),
                      // subtitle: Text('Level ${node.level}'),
                      selectedColor: Colors.blue,
                      selected: _selectedTreeNode == node,
                    );
                  }
                ),
              ),
              _createPipelineMode ? Container() :
              SizedBox(
                height: 50,
                child: TextButton.icon(
                  icon: const Icon(Icons.add),
                  label: Text(_getPipelineType()),
                  onPressed: _createPipeline,
                ),
              ),      
            ],
          )
        );
      },
    );
  }
}