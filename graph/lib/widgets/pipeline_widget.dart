import 'package:flutter/material.dart';
import 'package:graph/widgets/pipeline_layer.dart';
import 'package:flutter_map/flutter_map.dart';


class PipelineWidget extends StatefulWidget {
  const PipelineWidget({super.key});

  @override
  State<PipelineWidget> createState() => _PipelineWidgetState();
}

class _PipelineWidgetState extends State<PipelineWidget> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
        mapController: MapController(),
        options: const MapOptions(
          minZoom: 12,
          maxZoom: 17,
          interactionOptions: InteractionOptions(
            // Disable default map interactions
            // flags: InteractiveFlag.none
          )
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          const PipelineLayer(),
        ],
    );
  }
}