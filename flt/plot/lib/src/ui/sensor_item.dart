// sensor_item.dart
import 'package:flutter/material.dart';
import '../models/sensors/sensor_abstract.dart';
import '../enums/enums_sensor.dart';
import '../utils/helpers.dart';

class SensorItem extends StatefulWidget {
  final Sensor sensor;

  const SensorItem({Key? key, required this.sensor}) : super(key: key);

  @override
  SensorItemState createState() => SensorItemState();
}

class SensorItemState extends State<SensorItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      semanticContainer: true,
      elevation: 5,
      margin: EdgeInsets.all(10),
      color: isSelected ? theme.primaryColorLight : null,
      child: ListTile(
        title: Text('Sensor Tag: ${widget.sensor.tag}'),
        dense: true,
        visualDensity: VisualDensity(vertical: -3),
        onTap: () {
          setState(() {
            isSelected = !isSelected;
          });
        },
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${widget.sensor.type.displayString}'),
            Text(
                'Date Production: ${formatDate(widget.sensor.dateProduction)}'),
            Text(
                'Date Installation: ${formatDate(widget.sensor.dateInstallation)}'),
            Text(
                'Design Corrosion Rate: ${widget.sensor.designCorrosionRate.displayString}'),
            Text('State: ${widget.sensor.state.displayString}'),
            Text(
                'Date Next Service: ${formatDate(widget.sensor.dateNextService)}'),
            Text('Service Comment: ${widget.sensor.serviceComment}'),
          ],
        ),
      ),
    );
  }
}
