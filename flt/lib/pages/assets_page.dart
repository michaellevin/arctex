import 'package:arktech/widgets/tree_widget.dart';
import 'package:flutter/material.dart';


class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}


class _AssetsPageState extends State<AssetsPage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TreeWidget(),
        // Expanded(child: const Text("Assets")),
      ],
    );
  }
}