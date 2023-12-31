// sensor_list_view.dart
import 'package:flutter/material.dart';
import 'sensor_item.dart';
import '../models/sensors/sensor_abstract.dart'; // Import your Sensor model

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

  void _addSensor() {
    // Display a dialog to enter details for the new sensor
    // On dialog confirmation, create a Sensor object and call _addSensorToList
  }

  void _addSensorToList(Sensor sensor) {
    setState(() {
      _localSensors.add(sensor);
    });
  }

  void _removeSensor(Sensor sensor) {
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
          top: 100,
          child: FloatingActionButton(
            onPressed: () => _addSensor(),
            tooltip: 'Add Sensor',
            child: const Icon(Icons.add),
          ),
        ),
        // FloatingActionButton(
        //   onPressed: () => _addSensor(),
        //   tooltip: 'Add Sensor',
        //   child: const Icon(Icons.add),
        // ),
      ],
    );
  }
}
