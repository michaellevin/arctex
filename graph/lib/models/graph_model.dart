import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong;


abstract class GraphModel {
  List<latlong.LatLng> latLng;

  GraphModel(this.latLng) {
    if (latLng.isEmpty) {
      throw Exception('Unable to create GaphModel: latitude and longitude list is empty.');
    }
  }

  bool contains(MapCamera camera, Offset point);
  void draw(MapCamera camera, Canvas canvas, Paint paint);
}


class Well extends GraphModel {
  double rectWidth = 35;
  double rectHeight = 20;

  Well(super.latLng);

  @override
  bool contains(MapCamera camera, Offset point) {
    var c = camera.latLngToScreenPoint(latLng.first);
    var rect = Rect.fromCenter(center: Offset(c.x, c.y), width: rectWidth, height: rectHeight);
    return rect.contains(point);
  }

  @override
  void draw(MapCamera camera, Canvas canvas, Paint paint) {
    var c = camera.latLngToScreenPoint(latLng.first);
    var rect = Rect.fromCenter(center: Offset(c.x, c.y), width: rectWidth, height: rectHeight);
    canvas.drawRect(rect, paint);
  }
}


class Pipeline extends GraphModel {
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
    for (var i = 0; i < latLng.length - 1; i++) {
      var p1 = camera.latLngToScreenPoint(latLng[i]);
      var p2 = camera.latLngToScreenPoint(latLng[i+1]);
      if (projDistance(p1, p2, point.toPoint()) < 10) {
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