import 'dart:math';
import 'dart:ui';
import 'package:flutter_map/flutter_map.dart';
import 'graph_model.dart';

class Pipeline extends GraphModel {
  int get selectionThreshold => 5;

  Pipeline(super.latLng);

  double projDistance(Point<double> p1, Point<double> p2, Point<double> q) {
    var dx = p2.x - p1.x;
    var dy = p2.y - p1.y;

    var dotProduct = ((q.x - p1.x) * dx + (q.y - p1.y) * dy);
    var squaredLength = dx * dx + dy * dy;

    var scaleFactor = dotProduct / squaredLength;

    var projX = p1.x + scaleFactor * dx;
    var projY = p1.y + scaleFactor * dy;

    var dist = Point<double>(projX, projY).distanceTo(q);
    return dist;
  }

  @override
  bool contains(MapCamera camera, Offset point) {
    var zoomRatio =
        (camera.zoom - camera.minZoom!) / (camera.maxZoom! - camera.minZoom!);
    for (var i = 0; i < latLng.length - 1; i++) {
      var p1 = camera.latLngToScreenPoint(latLng[i]);
      var p2 = camera.latLngToScreenPoint(latLng[i + 1]);
      if (projDistance(p1, p2, point.toPoint()) <
          selectionThreshold * max(0.1, zoomRatio)) {
        return true;
      }
    }
    return false;
  }

  @override
  void draw(MapCamera camera, Canvas canvas, Paint paint) {
    var path = Path();
    var screenPoint = camera.latLngToScreenPoint(latLng.first);
    path.moveTo(screenPoint.x, screenPoint.y);
    for (var i = 0; i < latLng.length; i++) {
      screenPoint = camera.latLngToScreenPoint(latLng[i]);
      path.lineTo(screenPoint.x, screenPoint.y);
    }
    canvas.drawPath(path, paint);
  }
}
