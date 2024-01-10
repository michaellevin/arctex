import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'graph_model.dart';

class Well extends GraphModel {
  double rectWidth = 35;
  double rectHeight = 20;

  Well(super.latLng);

  @override
  bool contains(MapCamera camera, Offset point) {
    var c = camera.latLngToScreenPoint(latLng.first);
    var rect = Rect.fromCenter(
        center: Offset(c.x, c.y), width: rectWidth, height: rectHeight);
    return rect.contains(point);
  }

  @override
  void draw(MapCamera camera, Canvas canvas, Paint paint) {
    var c = camera.latLngToScreenPoint(latLng.first);
    var rect = Rect.fromCenter(
        center: Offset(c.x, c.y), width: rectWidth, height: rectHeight);
    canvas.drawRect(rect, paint);
  }
}
