import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../services/er_csv_data_parser.dart';

class SensorChart extends StatelessWidget {
  final List<ExtendedCsvData> csvData;

  const SensorChart({Key? key, required this.csvData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: const DateTimeAxis(),
      primaryYAxis: const NumericAxis(minimum: 0.01, maximum: 0.05),
      title: const ChartTitle(text: 'Date/Metal Loss'),
      series: <CartesianSeries<dynamic, dynamic>>[
        LineSeries<ExtendedCsvData, DateTime>(
          dataSource: csvData,
          xValueMapper: (ExtendedCsvData data, _) => data.originalData.date,
          yValueMapper: (ExtendedCsvData data, _) => data.metalLoss,
          dataLabelSettings: const DataLabelSettings(isVisible: false),
        )
      ],
      trackballBehavior: TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.singleTap, // or ActivationMode.longPress
        tooltipSettings: const InteractiveTooltip(enable: true),
      ),
      zoomPanBehavior: ZoomPanBehavior(
        enablePanning: true,
        enablePinching: true,
        zoomMode: ZoomMode.x, // Enable zooming along the x-axis
        enableMouseWheelZooming: true,
      ),
    );
  }
}
