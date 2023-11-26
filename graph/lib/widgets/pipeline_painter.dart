import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:graph/models/graph_model.dart';


class PipelinePainter extends CustomPainter {
  Paint highlightPaint = Paint()
    ..color = Colors.yellow;
  Paint wellPaint = Paint()
    ..color = Colors.blue;
  Paint strokePaint = Paint()
    ..color = Colors.green
    ..style = PaintingStyle.stroke
    ..strokeWidth = 6;
  Paint highlightStrokePaint = Paint()
    ..color = Colors.yellow
    ..style = PaintingStyle.stroke
    ..strokeWidth = 6;

  MapCamera camera;

  List<GraphModel> shapes;
  int selectionIndex;
  bool forceUpdateOnEdit;

  PipelinePainter(this.camera, this.shapes, this.selectionIndex, this.forceUpdateOnEdit);

  Paint getPaint(GraphModel model, int index) {
    if (model is Pipeline) {
      return selectionIndex == index ? highlightStrokePaint : strokePaint;
    }
    return selectionIndex == index ? highlightPaint : wellPaint;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Use scale as multiplier to w/h for rectangles to resize node according to camera zoom.
    // var scale = 1 - ((17 - zoom) / 5);
    for (var (i, n) in shapes.indexed) {
      n.draw(camera, canvas, getPaint(n, i));
    }
  }

  @override
  bool shouldRepaint(PipelinePainter oldDelegate) {
    return selectionIndex != oldDelegate.selectionIndex
           || forceUpdateOnEdit != oldDelegate.forceUpdateOnEdit;
  }
}
