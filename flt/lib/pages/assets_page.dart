import 'package:arktech/widgets/tree_widget.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:flutter/material.dart';


/// Collection of Australia state code data.
class Model {
  final String state;
  const Model(this.state);
}


class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}


class _AssetsPageState extends State<AssetsPage> {
  late MapShapeSource _mapSource;
  late List<Model> _data;

  @override
  void initState() {
    _mapSource = MapShapeSource.asset(
      'assets/australia.json',
      shapeDataField: 'STATE_NAME',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TreeWidget(),
        Expanded(
          child: SfMaps(
            layers: [
              MapShapeLayer(
                source: _mapSource
              )
            ]
          )
        ),
      ],
    );
  }
}