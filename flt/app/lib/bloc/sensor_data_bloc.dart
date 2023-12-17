import 'package:arctex/models/sensor_model.dart';
import 'package:arctex/tools/sensor_data_provider.dart';
import 'package:bloc/bloc.dart';

class SensorEvent {}

class SensorReadEvent extends SensorEvent {
  final String sensorId;
  SensorReadEvent(this.sensorId);
}

class SensorState {}

class SensorReadyState extends SensorState {
  final List<SensorDataModel> sensorData;
  SensorReadyState(this.sensorData);
}

class SensorBloc extends Bloc<SensorEvent, SensorState> {
  SensorBloc() : super(SensorState()) {
    on<SensorReadEvent>(_readData);
  }

  void _readData(SensorReadEvent event, Emitter emit) async {
    var data = await SensorDataProvider.readData(event.sensorId);
    emit(SensorReadyState(data));
  }
}
