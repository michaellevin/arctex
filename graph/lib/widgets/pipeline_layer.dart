import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:graph/models/graph_model.dart';
import 'package:graph/widgets/pipeline_painter.dart';
import 'package:latlong2/latlong.dart';


class PipelineLayer extends StatefulWidget {
  const PipelineLayer({super.key});

  @override
  State<PipelineLayer> createState() => _PipelineLayerState();
}


class _PipelineLayerState extends State<PipelineLayer> {
  int selectionIndex = -1;
  bool editMode = true;
  bool forceRepaint = false;

  List<GraphModel> shapes = [
    Well([const LatLng(50.5, 30.5)]),
    Well([const LatLng(50.505, 30.5)]),
    Well([const LatLng(50.5, 30.51)]),
    Pipeline([
      const LatLng(50.5, 30.5),
      const LatLng(50.501, 30.5015),
      const LatLng(50.503, 30.5016),
      const LatLng(50.505, 30.5),
    ]),
  ];

  void onTapDown(TapDownDetails details, MapCamera camera) {
    for (var (i, n) in  shapes.indexed) {
      if (n.contains(camera, details.globalPosition)) {
        setState(() {
          selectionIndex = i;
        });
        return;
      }
    }
    setState(() {
      selectionIndex = -1;
    });
  }

  void onPanUpdate(DragUpdateDetails details, MapCamera camera) {
    if (selectionIndex == -1) {
      return;
    }
    shapes[selectionIndex].latLng.first = camera.pointToLatLng(details.globalPosition.toPoint());
    setState(() {
      forceRepaint = !forceRepaint;
    });
  }

  void onPanEnd(DragEndDetails details) {
    if (selectionIndex == -1) {
      return;
    }
    setState(() {
      forceRepaint = !forceRepaint;
    });
  }  

  @override
  Widget build(BuildContext context) { 
    var camera = MapCamera.of(context);
    var controller = MapController.of(context);
    var options = MapOptions.of(context);

    return MobileLayerTransformer(
      child: GestureDetector(
        onTapDown: (details) => onTapDown(details, camera),
        onPanUpdate: editMode ? (details) => onPanUpdate(details, camera) : null,
        onPanEnd: editMode ? (details) => onPanEnd(details) : null,
        child: CustomPaint(
          painter: PipelinePainter(camera, shapes, selectionIndex, forceRepaint),
        ),
      )
    );
  }
}