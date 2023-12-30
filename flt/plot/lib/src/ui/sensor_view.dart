// sensor_list_view.dart
import 'package:flutter/material.dart';
import 'sensor_item.dart';
import '../models/sensors/sensor_abstract.dart'; // Import your Sensor model

class SensorListView extends StatelessWidget {
  final List<Sensor> sensors;
  final VoidCallback onAddSensor; // Callback for the add button

  const SensorListView(
      {Key? key, required this.sensors, required this.onAddSensor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: sensors.length,
            itemBuilder: (context, index) {
              return SensorItem(sensor: sensors[index]);
            },
          ),
        ),
        FloatingActionButton(
          onPressed: onAddSensor,
          tooltip: 'Add Sensor',
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
