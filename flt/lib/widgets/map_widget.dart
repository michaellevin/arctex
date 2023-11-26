import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';


class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  late MapShapeSource _mapSource;
  List<Map<String, dynamic>> _markers = [{
    "id": 0,
    "lat": 61.52401,
    "long": 105.318756,
  }];
  late MapShapeLayerController _controller;

  @override
  void initState() {
    _mapSource = const MapShapeSource.asset(
      'assets/custom.geo.json',
      shapeDataField: 'sovereignt',
    );
    _controller = MapShapeLayerController();    
    super.initState();
  }

  void doSomething(List<Map<String, dynamic>> markers) {
    setState(() {
      _markers = markers;
    });
    _controller.clearMarkers();
    for (var i = 0; i < markers.length; i++) {
      _controller.insertMarker(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SfMaps(
        layers: [
          MapShapeLayer(
            source: _mapSource,
            // zoomPanBehavior: MapZoomPanBehavior(),
          ),
          MapShapeLayer(
            source: _mapSource,
            initialMarkersCount: _markers.length,
            zoomPanBehavior: MapZoomPanBehavior(
              enableMouseWheelZooming: true,
              // focalLatLng: MapLatLng(61.52401, 105.318756),
              // zoomLevel: 5,
            ),
            controller: _controller,
            markerBuilder: (BuildContext context, int index) {
              return MapMarker(
                latitude: _markers[index]["lat"],//61.52401,
                longitude: _markers[index]["long"],//105.318756,
                iconColor: Colors.blue,
                child: GestureDetector(
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: const Icon(
                      Icons.circle,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  onTap: () => print("Tap"),
                ),
              );
            },
          ),
        ]
      )
    );
  }
}