import 'package:flutter/material.dart';
import 'sensor_chart.dart';

import '../services/er_csv_data_parser.dart';

class SensorChartView extends StatefulWidget {
  final List<ExtendedCsvData> csvData;

  const SensorChartView({
    Key? key,
    required this.csvData,
  }) : super(key: key);

  @override
  SensorChartViewState createState() => SensorChartViewState();
}

class SensorChartViewState extends State<SensorChartView> {
  final GlobalKey<SensorChartState> sensorChartKey = GlobalKey();

  void _toggleDerivative() {
    // Accessing the SensorChartState and toggling the showDerivative flag
    sensorChartKey.currentState?.toggleShowDerivative();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: ElevatedButton(
            onPressed: _toggleDerivative,
            child: Text('view CR'),
          ),
        ),
        Expanded(
          child: SensorChart(
            key: sensorChartKey, // Assigning the GlobalKey to SensorChart
            initialCsvData: widget.csvData,
            // Initially, showDerivative can be set to true or false as needed
            showDerivative: false,
          ),
        ),
      ],
    );
  }
}
