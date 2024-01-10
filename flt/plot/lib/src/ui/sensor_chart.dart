import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../services/er_csv_data_parser.dart';

class DerivativeData {
  DateTime date;
  double derivativeValue;

  DerivativeData(this.date, this.derivativeValue);
}

List<DerivativeData> calculateDerivative(List<ExtendedCsvData> csvData) {
  List<DerivativeData> derivativeData = [];

  for (int i = 1; i < csvData.length; i++) {
    // Calculate the time difference in a suitable unit (days, hours, etc.)
    var timeDiff = csvData[i]
        .originalData
        .date
        .difference(csvData[i - 1].originalData.date)
        .inDays;
    if (timeDiff == 0) continue; // Avoid division by zero

    // Calculate the derivative (rate of change)
    var rateOfChange =
        (csvData[i].metalLoss - csvData[i - 1].metalLoss) / timeDiff;

    // Use the average date between two points for the derivative's date
    var derivativeDate = DateTime(
        (csvData[i].originalData.date.millisecondsSinceEpoch +
                csvData[i - 1].originalData.date.millisecondsSinceEpoch) ~/
            2);

    derivativeData.add(DerivativeData(derivativeDate, rateOfChange));
  }

  return derivativeData;
}

class SensorChart extends StatefulWidget {
  final List<ExtendedCsvData> initialCsvData;
  final bool showDerivative;

  const SensorChart(
      {Key? key, required this.initialCsvData, this.showDerivative = false})
      : super(key: key);

  @override
  SensorChartState createState() => SensorChartState();
}

class SensorChartState extends State<SensorChart> {
  late List<ExtendedCsvData> csvData;
  late bool showDerivative;

  SensorChartState() : csvData = [];

  @override
  void initState() {
    super.initState();
    csvData = widget.initialCsvData;
    showDerivative = widget.showDerivative;
  }

  void updateData(List<ExtendedCsvData> newData) {
    setState(() {
      csvData = newData;
    });
  }

  void toggleShowDerivative() {
    setState(() {
      showDerivative = !showDerivative;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<DerivativeData> derivativeData = calculateDerivative(csvData);

    return SfCartesianChart(
      primaryXAxis: const DateTimeAxis(),
      primaryYAxis: const NumericAxis(minimum: 0.01, maximum: 0.05),
      title: ChartTitle(
          text: showDerivative ? 'Date/Corrosion Rate' : 'Date/Metal Loss'),
      series: <CartesianSeries<dynamic, dynamic>>[
        LineSeries<ExtendedCsvData, DateTime>(
          dataSource: csvData,
          xValueMapper: (ExtendedCsvData data, _) => data.originalData.date,
          yValueMapper: (ExtendedCsvData data, _) => data.metalLoss,
          dataLabelSettings: const DataLabelSettings(isVisible: false),
        ),
        if (showDerivative)
          LineSeries<DerivativeData, DateTime>(
            dataSource: derivativeData,
            xValueMapper: (DerivativeData data, _) => data.date,
            yValueMapper: (DerivativeData data, _) => data.derivativeValue,
            dataLabelSettings: const DataLabelSettings(isVisible: false),
          ),
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
