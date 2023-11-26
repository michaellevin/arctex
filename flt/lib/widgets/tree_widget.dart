import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';


class TreeWidget extends StatelessWidget {
  final Function(Map<String, String>) onSelect;
  final TreeNode simpleTree = TreeNode.root(data: {"title": "Root"});
  final Results companies;

  TreeWidget(this.companies, this.onSelect, {super.key}) {
    buildTree();
  }

  void addRoot(List<dynamic> list, String owner) {
    var pageFiltered = list.where((element) => element["Owner"] == owner);
    
    var node = TreeNode(data: {"title": owner});

    for (var c in pageFiltered) {
      var n = TreeNode(data: {"title": c["Unit name"] as String});
      node.add(n);
    }

    simpleTree.add(node);
  }

  void buildTree() async {
    // addRoot(companies, "Gazprom");
    // addRoot(companies, "Rosneft");

    for (var c in companies) {
      // var node = TreeNode(data: {"title": c.});
      print("adding root: $c");

    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: 300,
      child: TreeView.simple(
        tree: simpleTree,
        showRootNode: false,
        onItemTap: (nodeData) => onSelect(nodeData.data),
        builder: (context, node) {
            // build your node item here
            // return any widget that you need
            return ListTile(
              title: Text("${node.data['title']}"),
              subtitle: Text('Level ${node.level}'),
            );
        }
      )
    );
  }
}