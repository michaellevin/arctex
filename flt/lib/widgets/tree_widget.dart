import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';


class TreeWidget extends StatelessWidget {

  TreeNode simpleTree = TreeNode.root();

  TreeWidget({super.key}) {
    var l3Node = TreeNode(key: "key L3");
    var l2Node = TreeNode(key: "key L2");
    l2Node.add(l3Node);
    simpleTree.add(l2Node);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: 300,
      child: TreeView.simple(
        tree: simpleTree,
        builder: (context, node) {
            // build your node item here
            // return any widget that you need
            return ListTile(
              title: Text("Item ${node.level}-${node.key}"),
              subtitle: Text('Level ${node.level}'),
              onTap: () => print(node.key),
            );
        }
      )
    );
  }
}