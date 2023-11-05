import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const MyApp());
}

class SensorData {
  SensorData(this.date, this.value);
  final String date;
  final double value;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ARCTEX',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'APKTEX'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SensorData> thicknessValues = [];
  List<SensorData> temperatureValues = [];
  String sensorTitle = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGraph();
  }

  Future<void> getGraph() async {
    String data = await rootBundle.loadString("10559.json"); // 10559 or 10839
    Map<String, dynamic> rawLinesData = jsonDecode(data);
    String sensorId = rawLinesData.keys.first;
    List<SensorData> yThickness = []; // temp array
    List<SensorData> yTemperature = []; // temp array

    for (var timeEntry in rawLinesData.entries.first.value.entries) {
      var timestamp = timeEntry.key.toString().split("T")[0];
      if (!timestamp.startsWith('2023')) {
        continue;
      }

      var yThick = timeEntry.value["thickness"];
      var yTemp = timeEntry.value["temperature"];

      yThickness.add(SensorData(timestamp, yThick));
      yTemperature.add(SensorData(timestamp, yTemp));
    }

    setState(() {
      thicknessValues = yThickness;
      temperatureValues = yTemperature;
      sensorTitle = sensorId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.black,
              width: 65,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.auto_graph,
                    color: Colors.white,
                    size: 35,
                  ),
                  Icon(Icons.gavel_sharp, color: Colors.white, size: 35),
                  Icon(Icons.settings, color: Colors.white, size: 35),
                  Icon(Icons.person, color: Colors.white, size: 35),
                  Icon(Icons.refresh, color: Colors.white, size: 35),
                ],
              ),
            ),
            Expanded(
                child: SfCartesianChart(
                    title: ChartTitle(text: sensorTitle),
                    primaryXAxis:
                        CategoryAxis(title: AxisTitle(text: 'Дата и время')),
                    primaryYAxis: NumericAxis(
                        title: AxisTitle(text: 'Потеря металла, мм')),
                    zoomPanBehavior: ZoomPanBehavior(
                      enableMouseWheelZooming: true,
                      enablePanning: true,
                    ),
                    crosshairBehavior: CrosshairBehavior(
                      shouldAlwaysShow: true,
                      enable: true,
                      lineType: CrosshairLineType.both,
                      activationMode: ActivationMode.singleTap,
                      lineColor: Colors.red,
                      lineWidth: 1,
                      lineDashArray: <double>[5, 5],
                    ),
                    axes: [
                  NumericAxis(
                      name: 'thickAxis',
                      opposedPosition: true,
                      minimum: -20,
                      maximum: 20,
                      title: AxisTitle(text: 'Скорость коррозии, мм/год')),
                  NumericAxis(
                      name: 'tempAxis',
                      opposedPosition: true,
                      minimum: -1,
                      maximum: 1,
                      interval: 1,
                      title: AxisTitle(text: 'Температура, С')),
                ],
                    series: <ChartSeries>[
                  LineSeries<SensorData, String>(
                    dataSource: thicknessValues,
                    xValueMapper: (SensorData sensorData, _) => sensorData.date,
                    yValueMapper: (SensorData sensorData, _) =>
                        sensorData.value,
                  ),
                  // ColumnSeries<SensorData, String>(
                  //     dataSource: temperatureValues,
                  //     xValueMapper: (SensorData sensorData, _) =>
                  //         sensorData.date,
                  //     yValueMapper: (SensorData sensorData, _) =>
                  //         sensorData.value,
                  //     yAxisName: 'thickAxis'),
                  LineSeries<SensorData, String>(
                      dataSource: temperatureValues,
                      xValueMapper: (SensorData sensorData, _) =>
                          sensorData.date,
                      yValueMapper: (SensorData sensorData, _) =>
                          sensorData.value,
                      yAxisName: 'tempAxis'),
                ]))
          ],
        ),
      ),
    );
  }
}
