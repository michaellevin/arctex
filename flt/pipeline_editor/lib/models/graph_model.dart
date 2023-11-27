import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong;

abstract class GraphModel {
  List<latlong.LatLng> latLng;

  GraphModel(this.latLng) {
    if (latLng.isEmpty) {
      throw Exception(
          'Unable to create GaphModel: latitude and longitude list is empty.');
    }
  }

  bool contains(MapCamera camera, Offset point);
  void draw(MapCamera camera, Canvas canvas, Paint paint);
}
