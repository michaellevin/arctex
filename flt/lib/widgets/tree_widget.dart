import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';


class TreeWidget extends StatelessWidget {

  TreeNode simpleTree = TreeNode.root(data: {"title": "Root"});

  TreeWidget({super.key}) {
    var l11Node = TreeNode(data: {"title": 'ОАО "Нефтегаз"'});
    var l12Node = TreeNode(data: {"title": 'ОАО "Нефтегаз/Добыча"'});
    var l1Node = TreeNode(data: {"title": 'ПАО "Газпром"'});
    var l2Node = TreeNode(data: {"title": 'Блок "Разведка/Добыча"'});
    var l3Node = TreeNode(data: {"title": 'ООО "Газпрос добыча Уренгой"'});
    l1Node.add(l2Node);
    l2Node.add(l3Node);
    simpleTree.add(l1Node);
    l11Node.add(l12Node);
    simpleTree.add(l11Node);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: 300,
      child: TreeView.simple(
        tree: simpleTree,
        showRootNode: false,
        builder: (context, node) {
            // build your node item here
            // return any widget that you need
            return ListTile(
              title: Text("${node.data['title']}"),
              subtitle: Text('Level ${node.level}'),
              onTap: () => print(node.key),
            );
        }
      )
    );
  }
}