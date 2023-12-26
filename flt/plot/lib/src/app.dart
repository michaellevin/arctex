import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'core/sensors_strategies/er_csv_data_parser.dart';
import 'core/sensors.dart';

class PlotApp extends StatefulWidget {
  const PlotApp({Key? key}) : super(key: key);

  @override
  State<PlotApp> createState() => _PlotAppState();
}

class _PlotAppState extends State<PlotApp> {
  List<ERSensor> erSensors = [];
  // List<CsvData> csvData = [];
  List<ExtendedCsvData> csvData = [];
  bool isCsvDataLoaded = false;

  @override
  void initState() {
    super.initState();

    // Load ER sensors
    loadERSensors();
  }

  Future<void> loadERSensors() async {
    List<ERSensor> sensors = await loadERSensorsFromAssets();
    setState(() {
      erSensors = sensors;
    });
  }

  Future<void> loadCsvData(ERSensor currentSensor) async {
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
    // Additional variables from the current sensor
    double area =
        currentSensor.referenceSampleArea; // Replace with actual property name
    double diameter =
        currentSensor.innerDiameter; // Replace with actual property name
    // Create a list of ExtendedCsvData
    List<ExtendedCsvData> extendedData = [];
    for (var data in filteredData) {
      double corrodedArea = area / data.ratio;
      double realThickness =
          sqrt(diameter * diameter + corrodedArea / pi) - diameter;
      double metalLoss = 1.0 - realThickness;

      extendedData
          .add(ExtendedCsvData(originalData: data, metalLoss: metalLoss));
    }

    extendedData.forEach((data) {
      print(data.metalLoss);
    });

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
          title: const Text('CSV Data Display'),
        ),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: erSensors.length,
              itemBuilder: (context, index) {
                return _buildSensorItem(erSensors[index]);
              },
            ),
          ),
          isCsvDataLoaded
              // ? Expanded(
              //     child: ListView.builder(
              //       itemCount: csvData.length,
              //       itemBuilder: (context, index) {
              //         return ListTile(
              //           title: Text(csvData[index].date.toString()),
              //           subtitle: Text('Ratio: ${csvData[index].ratio}'),
              //         );
              //       }
              //     )
              //   )
              ? SfCartesianChart(
                  primaryXAxis: const DateTimeAxis(),
                  primaryYAxis:
                      // const NumericAxis(minimum: 0.99, maximum: 1.060),
                      const NumericAxis(minimum: 0.01, maximum: 0.05),
                  title: const ChartTitle(text: 'Date/Metal Loss'),
                  series: <CartesianSeries<dynamic, dynamic>>[
                    // LineSeries<CsvData, DateTime>(
                    //   dataSource: csvData,
                    //   xValueMapper: (CsvData data, _) => data.date,
                    //   yValueMapper: (CsvData data, _) => data.ratio,
                    //   dataLabelSettings:
                    //       const DataLabelSettings(isVisible: false),
                    // )
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

  Widget _buildSensorItem(ERSensor sensor) {
    return Card(
      child: ListTile(
        title: Text('Sensor Tag: ${sensor.tag}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${sensor.type}'),
            Text('Date Production: ${sensor.dateProduction.toString()}'),
            Text('Date Installation: ${sensor.dateInstallation.toString()}'),
            Text('Project Corrosion Rate: ${sensor.projectCorrosionRate}'),
            Text('State: ${sensor.state}'),
            Text('Date Next Service: ${sensor.dateNextService.toString()}'),
            Text('Service Comment: ${sensor.serviceComment}'),
          ],
        ),
      ),
    );
  }
}
