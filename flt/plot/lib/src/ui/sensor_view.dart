// sensor_list_view.dart
import 'package:flutter/material.dart';

import 'sensor_item.dart';

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

  void _addSensor() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // A Key to validate and save form fields
        final _formKey = GlobalKey<FormState>();

        String _sensorTag = '';
        SensorType _selectedSensorType = SensorType.er;
        ErType _selectedERType = ErType.smallEnd;
        InnerDiameter _selectedInnerDiameter = InnerDiameter.diameter8;
        ReferenceSampleArea _selectedReferenceSampleArea =
            ReferenceSampleArea.area_53_41;

        return AlertDialog(
          title: const Text('Add New ER Sensor'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Введите тэг'),
                    onSaved: (value) {
                      _sensorTag = value ?? '';
                    },
                    // Add validator if needed
                  ),
                  DropdownButtonFormField<SensorType>(
                    decoration: const InputDecoration(labelText: 'Тип датчика'),
                    value: _selectedSensorType,
                    items: SensorType.values.map((SensorType type) {
                      return DropdownMenuItem<SensorType>(
                        value: type,
                        child: Text(type.displayString),
                      );
                    }).toList(),
                    onChanged: null, // Make dropdown disabled
                    onSaved: (SensorType? value) {
                      if (value != null) {
                        _selectedSensorType = value;
                      }
                    },
                  ),
                  DropdownButtonFormField<ErType>(
                    decoration: const InputDecoration(
                        labelText: 'Конфигурация чувствительного элемента'),
                    value: _selectedERType,
                    items: ErType.values.map((ErType type) {
                      return DropdownMenuItem<ErType>(
                        value: type,
                        child: Text(type.displayString),
                      );
                    }).toList(),
                    onChanged: (ErType? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedERType = newValue;
                        });
                      }
                    },
                    onSaved: (ErType? value) {
                      if (value != null) {
                        _selectedERType = value;
                      }
                    },
                  ),
                  DropdownButtonFormField<ReferenceSampleArea>(
                    decoration: const InputDecoration(
                        labelText: 'Площадь эталонного образца'),
                    value: _selectedReferenceSampleArea,
                    items: ReferenceSampleArea.values
                        .map((ReferenceSampleArea type) {
                      return DropdownMenuItem<ReferenceSampleArea>(
                        value: type,
                        child: Text(type.displayString),
                      );
                    }).toList(),
                    onChanged: (ReferenceSampleArea? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedReferenceSampleArea = newValue;
                        });
                      }
                    },
                    onSaved: (ReferenceSampleArea? value) {
                      if (value != null) {
                        _selectedReferenceSampleArea = value;
                      }
                    },
                  ),
                  DropdownButtonFormField<InnerDiameter>(
                    decoration:
                        const InputDecoration(labelText: 'Внутренний диаметр'),
                    value: _selectedInnerDiameter,
                    items: InnerDiameter.values.map((InnerDiameter type) {
                      return DropdownMenuItem<InnerDiameter>(
                        value: type,
                        child: Text(type.displayString),
                      );
                    }).toList(),
                    onChanged: (InnerDiameter? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedInnerDiameter = newValue;
                        });
                      }
                    },
                    onSaved: (InnerDiameter? value) {
                      if (value != null) {
                        _selectedInnerDiameter = value;
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                // Save form state and create new sensor object
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Sensor newSensor = ERSensor(
                    tag: _sensorTag,
                    erType: _selectedERType,
                    referenceSampleArea: _selectedReferenceSampleArea,
                    innerDiameter: _selectedInnerDiameter,
                  );
                  print(newSensor);
                  // _addSensorToList(newSensor);
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
            ),
          ],
        );
      },
    );
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
