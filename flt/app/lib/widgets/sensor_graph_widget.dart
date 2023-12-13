import 'package:arktech/bloc/sensor_data_bloc.dart';
import 'package:arktech/models/sensor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SensorDataWidget extends StatefulWidget {
  const SensorDataWidget({super.key});

  @override
  State<SensorDataWidget> createState() => _SensorDataWidgetState();
}

class _SensorDataWidgetState extends State<SensorDataWidget> {
  String sensorTitle = "XXX";

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SensorBloc, SensorState>(
      builder: (context, state) {
        if (state is! SensorReadyState) {
          return const Center(child: Text("No data"));
        }

        return Expanded(
          child: SfCartesianChart(
              title: ChartTitle(text: sensorTitle),
              primaryXAxis: DateTimeAxis(
                title: AxisTitle(text: 'Дата и время'),
                dateFormat: DateFormat('yyyy-MM-dd HH:mm'),
                intervalType: DateTimeIntervalType.auto,
              ),
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
                    name: 'tempAxis',
                    opposedPosition: true,
                    title: AxisTitle(text: 'Температура, C')),
              ],
              series: <ChartSeries>[
                LineSeries<SensorDataModel, DateTime>(
                  dataSource: state.sensorData,
                  xValueMapper: (SensorDataModel sensorData, _) => sensorData.date,
                  yValueMapper: (SensorDataModel sensorData, _) => sensorData.thickness,
                ),
                LineSeries<SensorDataModel, DateTime>(
                  dataSource: state.sensorData,
                  xValueMapper: (SensorDataModel sensorData, _) => sensorData.date,
                  yValueMapper: (SensorDataModel sensorData, _) => sensorData.temperature,
                  yAxisName: 'tempAxis'
                ),
              ]
            )
        );
      }
    );
  }
}