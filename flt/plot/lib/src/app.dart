import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'services/er_csv_data_parser.dart';
import 'models/sensors/sensor_abstract.dart';
import 'models/sensors/sensor_er.dart';
import 'enums/enums_sensor.dart';
// import 'utils/helpers.dart';

// import 'ui/sensor_item.dart';
import 'ui/sensor_view.dart';

class PlotApp extends StatefulWidget {
  const PlotApp({Key? key}) : super(key: key);

  @override
  State<PlotApp> createState() => _PlotAppState();
}

class _PlotAppState extends State<PlotApp> {
  List<Sensor> erSensors = [];
  // List<CsvData> csvData = [];
  List<ExtendedCsvData> csvData = [];
  bool isCsvDataLoaded = false;

  @override
  void initState() {
    super.initState();

    // Register factories
    Sensor.registerFactory(SensorType.er, (json) => ERSensor.fromJson(json));

    // Load ER sensors
    loadERSensors();
  }

  Future<void> loadERSensors() async {
    List<Sensor> sensors = await loadSensorsFromAssets(SensorType.er);
    setState(() {
      erSensors = sensors;
    });
  }

  Future<void> loadCsvData(Sensor sensor) async {
    String rawCsv =
        await rootBundle.loadString('assets/sensors_data/ER/Sib113.csv');
    CsvParser parser = CsvParser();
    List<CsvData> rawData = parser.parseCsv(rawCsv);
    // print(csvData.length);

    // Calculate mean and standard deviation
    double mean = rawData.fold(0.0, (double sum, item) => sum + item.ratio) /
        rawData.length;
    double sumOfSquaredDiffs = rawData.fold(
        0, (sum, item) => sum + (item.ratio - mean) * (item.ratio - mean));
    double standardDeviation = sqrt(sumOfSquaredDiffs / rawData.length);

    // Filter out outliers
    List<CsvData> filteredData = rawData.where((data) {
      double deviation = (data.ratio - mean).abs();
      return deviation <= 2 * standardDeviation; // Change this factor as needed
    }).toList();

    // Print filtered data
    // filteredData.forEach((data) {
    //   print(data.ratio);
    // });

    // Calculate corrosion values
    List<ExtendedCsvData> extendedData = [];
    if (sensor is ERSensor) {
      // var erSensor = sensor as ERSensor;
      double area = sensor.referenceSampleArea.value;
      double diameter = sensor.innerDiameter.value;

      for (var data in filteredData) {
        double corrodedArea = area / data.ratio;
        double realThickness =
            sqrt(diameter * diameter + corrodedArea / pi) - diameter;
        double metalLoss = 1.0 - realThickness;
        extendedData
            .add(ExtendedCsvData(originalData: data, metalLoss: metalLoss));
      }
      // print
      extendedData.forEach((data) {
        print(data.metalLoss);
      });
    } else {
      // Handle the case where sensor is not ERSensor
    }

    // Update the state
    setState(() {
      // csvData = filteredData;
      csvData = extendedData;
      isCsvDataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ER Sensors',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sensor Monitoring'),
        ),
        body: Column(children: [
          Expanded(
            child: SensorListView(
              sensors: erSensors,
              onAddSensor: () {},
            ),
          ),
          isCsvDataLoaded
              ? SfCartesianChart(
                  primaryXAxis: const DateTimeAxis(),
                  primaryYAxis: const NumericAxis(minimum: 0.01, maximum: 0.05),
                  title: const ChartTitle(text: 'Date/Metal Loss'),
                  series: <CartesianSeries<dynamic, dynamic>>[
                    LineSeries<ExtendedCsvData, DateTime>(
                      dataSource: csvData,
                      xValueMapper: (ExtendedCsvData data, _) =>
                          data.originalData.date,
                      yValueMapper: (ExtendedCsvData data, _) => data.metalLoss,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false),
                    )
                  ],
                  trackballBehavior: TrackballBehavior(
                    enable: true,
                    activationMode:
                        ActivationMode.singleTap, // or ActivationMode.longPress
                    tooltipSettings: const InteractiveTooltip(enable: true),
                  ),
                  zoomPanBehavior: ZoomPanBehavior(
                    enablePanning: true,
                    enablePinching: true,
                    zoomMode: ZoomMode.x, // Enable zooming along the x-axis
                    enableMouseWheelZooming: true,
                  ),
                )
              : Container()
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (erSensors.isNotEmpty) {
              loadCsvData(erSensors[0]);
            } else {
              // Handle the case where erSensors is empty
            }
          },
          tooltip: 'Load CSV Data',
          child: const Icon(Icons.file_download),
        ),
      ),
    );
  }
}
