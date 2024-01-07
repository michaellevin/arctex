// sensor_list_view.dart
import 'package:flutter/material.dart';

import 'sensor_item.dart';
import 'add_sensor_item_alert.dart';

import '../models/sensors/sensor_abstract.dart'; // Import Sensor model
// import '../models/sensors/sensor_er.dart'; // Import ERSensor model
import '../enums/enums_sensor.dart'; // Import SensorType enum
// import '../enums/enums_sensor_er.dart'; // Import ErType enum

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
  late Set<Sensor> _selectedSensors;

  @override
  void initState() {
    super.initState();
    _localSensors =
        List.from(widget.sensors); // Initialize with a copy of widget.sensors
    _selectedSensors = {};
  }

  @override
  void didUpdateWidget(covariant SensorListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Whenever the parent widget updates the sensor list, update the local copy
    if (oldWidget.sensors != widget.sensors) {
      _localSensors = List.from(widget.sensors);
    }
  }

  // Toggle sensor selection
  void toggleSensorSelection(Sensor sensor) {
    setState(() {
      if (_selectedSensors.contains(sensor)) {
        _selectedSensors.remove(sensor);
      } else {
        _selectedSensors.add(sensor);
      }
    });
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
  void showConfirmRemoveDialog(List<Sensor> sensorsToRemove) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Removal'),
          content: const Text(
              'Are you sure you want to remove the selected sensors?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
            ),
            TextButton(
              child: const Text('Remove'),
              onPressed: () {
                sensorsToRemove.forEach(removeSensor);
                saveSensors();
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void removeSensor(Sensor sensor) {
    setState(() {
      _localSensors.remove(sensor);
      _selectedSensors.remove(sensor);
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
              Sensor sensor = _localSensors[index];
              SensorItem sensorItem = SensorItem(
                sensor: sensor,
                onToggleSelection: () => toggleSensorSelection(sensor),
              );
              return Stack(
                children: [
                  SizedBox(width: 300, child: sensorItem),
                  Positioned(
                    right: 11,
                    bottom: 36,
                    child: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          showConfirmRemoveDialog([sensor]), // Remove sensor
                    ),
                  )
                ],
              );
            },
          ),
        ),
        Positioned(
          right: 0,
          top: 36,
          child: FloatingActionButton(
            onPressed: () => showAddSensorDialog(),
            tooltip: 'Add an ER Sensor',
            child: const Icon(Icons.add),
          ),
        ),
        Positioned(
          right: 0,
          top: 100,
          child: FloatingActionButton(
            onPressed: () => showConfirmRemoveDialog(_selectedSensors.toList()),
            tooltip: 'Remove selected sensors',
            child: const Icon(Icons.delete),
          ),
        ),
      ],
    );
  }
}
