import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:arktech/bloc/sensor_data_bloc.dart';
import 'package:arktech/models/itree_node_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TreeWidget extends StatelessWidget {
  final TreeNode<ITreeNodeModel> _simpleTree = TreeNode.root(data: ITreeNodeModel(id: "root", name: "root", type: TreeNodeType.root));
  final List<ITreeNodeModel> _pipelines;

  TreeWidget(this._pipelines, {super.key}) {
    buildTree();
  }

  void buildTree() {
    var nodes = _pipelines.map((e) => TreeNode(data: e)).toList();

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

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: 300,
      child: TreeView.simple(
        tree: _simpleTree,
        showRootNode: false,
        onItemTap: (nodeData) {
          if (nodeData.isLeaf) {
            context.read<SensorBloc>().add(SensorReadEvent(nodeData.data!.id));
          }
        },
        builder: (context, node) {
            return ListTile(
              title: Text(node.data!.name),
              // subtitle: Text('Level ${node.level}'),
            );
        }
      )
    );
  }
}