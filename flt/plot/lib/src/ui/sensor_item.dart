// sensor_item.dart
import 'package:flutter/material.dart';
import '../models/sensors/sensor_abstract.dart';
import '../enums/enums_sensor.dart';
import '../utils/helpers.dart';

class SensorItem extends StatelessWidget {
  final Sensor sensor;

  const SensorItem({Key? key, required this.sensor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Sensor Tag: ${sensor.tag}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${sensor.type.displayString}'),
            Text('Date Production: ${formatDate(sensor.dateProduction)}'),
            Text('Date Installation: ${formatDate(sensor.dateInstallation)}'),
            Text(
                'Design Corrosion Rate: ${sensor.designCorrosionRate.displayString}'),
            Text('State: ${sensor.state.displayString}'),
            Text('Date Next Service: ${formatDate(sensor.dateNextService)}'),
            Text('Service Comment: ${sensor.serviceComment}'),
          ],
        ),
      ),
    );
  }
}
