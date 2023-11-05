import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle; 

void main() {
  runApp(const MyApp());
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class ChartData {
    ChartData(this.x, this.y, this.y1);
    final String x;
    final double? y;
    final double? y1;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ARKTEX',
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
  List<SalesData> line = [];
  List<SalesData> bars = [];

  @override 
  void initState() { 
    // TODO: implement initState 
    super.initState(); 
    getGraph();
  }   

  Future<List<SalesData>> getGraph() async {
    var l = <SalesData>[];
    String data = await rootBundle.loadString("assets/line.json");
    Map<String, dynamic> rawLinesData = jsonDecode(data)['10559'];
    Map<String, dynamic> cleanLinesData = <String, dynamic>{};

    for (var d in rawLinesData.entries) {
      var x = d.key.toString().split("T")[0];
      if (!x.startsWith('2023')) {
        continue;
      }
      
      var y = d.value["thickness"];
      cleanLinesData[x] = y;
    }

    for (var d in cleanLinesData.entries) {
      l.add(SalesData(d.key, d.value));
    }

    var b = <SalesData>[];
    var addedBars = <String>[];
    data = await rootBundle.loadString("assets/bars.json");
    Map<String, dynamic> barsResult = jsonDecode(data)['10839'];
    for (var d in barsResult.entries) {
      var x = d.key.toString().split("T")[0];
      // if (!cleanLinesData.keys.contains(x)) {
      //   print("no key: ${x}");
      //   continue;
      // }
      if (addedBars.contains(x)) {
        continue;
      }
      var y = d.value["thickness"];
      var neg = Random().nextBool();
      b.add(SalesData(x, neg ? y : -y));
      addedBars.add(x);
    }
    print(b.length);

    setState(() {
      line = l;
      bars = b;
    });

    return l;
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
                  Icon(Icons.auto_graph, color: Colors.white, size: 35,),
                  Icon(Icons.gavel_sharp, color: Colors.white,size: 35),
                  Icon(Icons.settings, color: Colors.white,size: 35),
                  Icon(Icons.person, color: Colors.white,size: 35),
                  Icon(Icons.refresh, color: Colors.white,size: 35),
                ],
              ),
            ),
            Expanded(
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  title: AxisTitle(text: 'Дата и время')
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(text: 'Потеря металла, мм')
                ),

                zoomPanBehavior: ZoomPanBehavior(
                  enableMouseWheelZooming: true,
                  enablePanning: true,
                ),

                axes: [
                  NumericAxis(
                    name: 'yAxis',
                    opposedPosition: true,
                    minimum: -20,
                    maximum: 20,
                    title: AxisTitle(text: 'Скорость коррозии, мм/год')
                  ),

                  NumericAxis(
                    name: 'tempAxis',
                    opposedPosition: true,
                    minimum: -1,
                    maximum: 1,
                    interval: 1,
                    title: AxisTitle(text: 'Температура, С')
                  ),
                ],


                series: <ChartSeries>[
                  LineSeries<SalesData, String>(
                    dataSource: line,
                    // dataSource:  <SalesData>[
                    //   SalesData('Jan', -25),
                    //   SalesData('Feb', 18),
                    //   SalesData('Mar', 14),
                    //   SalesData('Apr', 22),
                    //   SalesData('May', 50),
                    // ],
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales,
                  ),

                  ColumnSeries<SalesData, String>(
                    dataSource: bars,
                    // dataSource: <SalesData>[
                    //   SalesData('Jan', 35),
                    //   SalesData('Feb', 28),
                    //   SalesData('Mar', -14),
                    //   SalesData('Apr', 12),
                    //   SalesData('May', -30),
                    // ],
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales,
                    yAxisName: 'yAxis'
                  ),

                  LineSeries<SalesData, String>(
                    dataSource:  <SalesData>[
                      SalesData('2023-01-01', -1),
                      // SalesData('Feb', 1),
                    ],
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales,
                    yAxisName: 'tempAxis'
                  ),

                ]
              )
            )
          ],
        ),
      ),
    );
  }
}
