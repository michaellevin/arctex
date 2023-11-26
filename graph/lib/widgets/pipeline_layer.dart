import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:graph/widgets/pipeline_painter.dart';
import 'package:latlong2/latlong.dart';


class PipelineLayer extends StatefulWidget {
  const PipelineLayer({super.key});

  @override
  State<PipelineLayer> createState() => _PipelineLayerState();
}


class _PipelineLayerState extends State<PipelineLayer> {
  int selectionIndex = -1;

  List<LatLng> nodes = const [
    LatLng(50.5, 30.5),
    LatLng(50.505, 30.5),
    LatLng(50.5, 30.51),
  ];
  
  @override
  Widget build(BuildContext context) { 
    final camera = MapCamera.of(context);
    final controller = MapController.of(context);
    final options = MapOptions.of(context);

    double nodeWidth = 35;
    double nodeHeight = 20;

    return MobileLayerTransformer(
      child: GestureDetector(
        onTapDown: (details) {
          for (var (i, n) in  nodes.indexed) {
            var c = camera.latLngToScreenPoint(n);
            var rect = Rect.fromCenter(center: Offset(c.x, c.y), width: nodeWidth, height: nodeHeight);
            if (rect.contains(details.globalPosition)) {
              setState(() {
                selectionIndex = i;
              });
              return;
            }
          }
          setState(() {
            selectionIndex = -1;
          });
        },
        child: CustomPaint(
          painter: PipelinePainter(camera, nodes, selectionIndex),
        ),
      )
    );
  }
}