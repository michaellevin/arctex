import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class PipelinePainter extends CustomPainter {
  Paint highlightPaint = Paint()..color = Colors.yellow;
  Paint defaultPaint = Paint()..color = Colors.blue;

  MapCamera camera;

  List<LatLng> nodes;
  int selectionIndex;

  PipelinePainter(this.camera, this.nodes, this.selectionIndex);

  @override
  void paint(Canvas canvas, Size size) {
    // Use scale as multiplier to w/h for rectangles to resize node seize according to camera zoom.
    // var scale = 1 - ((17 - zoom) / 5);

    for (var (i, n) in nodes.indexed) {
      var c = camera.latLngToScreenPoint(n);
      var r = Rect.fromCenter(center: Offset(c.x, c.y), width: 35, height: 20);
      canvas.drawRect(r, selectionIndex == i ? highlightPaint : defaultPaint);
    }
  }

  @override
  bool shouldRepaint(PipelinePainter oldDelegate) {
    return selectionIndex != oldDelegate.selectionIndex;
  }
}
