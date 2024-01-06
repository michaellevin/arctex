// sensor_list_view.dart
import 'package:flutter/material.dart';

import 'sensor_item.dart';
import 'add_sensor_item_alert.dart';

import '../models/sensors/sensor_abstract.dart'; // Import Sensor model
import '../models/sensors/sensor_er.dart'; // Import ERSensor model
import '../enums/enums_sensor.dart'; // Import SensorType enum
import '../enums/enums_sensor_er.dart'; // Import ErType enum

class SensorListView extends StatefulWidget {
  final List<Sensor> sensors;
  final VoidCallback onAddSensor;

  const SensorListView(
      {Key? key, required this.sensors, required this.onAddSensor})
      : super(key: key);

  @override
  SensorListViewState createState() => SensorListViewState();
}

class SensorListViewState extends State<SensorListView> {
  late List<Sensor> _localSensors;

  @override
  void initState() {
    super.initState();
    _localSensors =
        List.from(widget.sensors); // Initialize with a copy of widget.sensors
  }

  @override
  void didUpdateWidget(covariant SensorListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Whenever the parent widget updates the sensor list, update the local copy
    if (oldWidget.sensors != widget.sensors) {
      _localSensors = List.from(widget.sensors);
    }
  }

  // Add sensors
  void addSensorToList(Sensor sensor) {
    setState(() {
      _localSensors.add(sensor);
    });
  }

  void saveSensors() {
    saveSensorsToFile(_localSensors, SensorType.er);
  }

  void showAddSensorDialog() {
    addERSensorDlg(context, addSensorToList, saveSensors);
  }

  // Remove sensor from the list
  void showConfirmRemoveDialog() {}

  void removeSensor(Sensor sensor) {
    setState(() {
      _localSensors.remove(sensor);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _localSensors.length,
            itemBuilder: (context, index) {
              return SizedBox(
                  width: 300, child: SensorItem(sensor: _localSensors[index]));
            },
          ),
        ),
        Positioned(
          right: 0,
          top: 36,
          child: FloatingActionButton(
            onPressed: () => showAddSensorDialog(),
            tooltip: 'Add Sensor',
            child: const Icon(Icons.add),
          ),
        ),
        Positioned(
          right: 0,
          top: 100,
          child: FloatingActionButton(
            onPressed: () => showConfirmRemoveDialog(),
            tooltip: 'Remove Sensor',
            child: const Icon(Icons.remove),
          ),
        ),
      ],
    );
  }
}
