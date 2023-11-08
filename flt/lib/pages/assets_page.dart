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
      'assets/custom.geo.json',
      shapeDataField: 'sovereignt',
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
                source: _mapSource,
                // zoomPanBehavior: MapZoomPanBehavior(),
              ),
              MapShapeLayer(
                source: _mapSource,
                initialMarkersCount: 5,
                zoomPanBehavior: MapZoomPanBehavior(
                  enableMouseWheelZooming: true
                ),
                markerBuilder: (BuildContext context, int index) {
                  return MapMarker(
                    latitude: 61.52401,
                    longitude: 105.318756,
                    iconColor: Colors.blue,
                    child: ElevatedButton(
                      child: Text("M"),
                      onPressed: () => print("pressed"),
                    ),
                  );
                },
              ),              
            ]
          )
        ),
      ],
    );
  }
}