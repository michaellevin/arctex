import 'package:arktech/models/pipeline_model.dart';
import 'package:arktech/tools/pipeline_data_provider.dart';
import 'package:bloc/bloc.dart';

class PipelineDataEvent {}
class PipelineDataReadEvent extends PipelineDataEvent {}
class PipelineDataAddEvent extends PipelineDataEvent {}

class PipelineDataState {}
class PipelineDataReadyState extends PipelineDataState {
  final List<PipelineModel> pipelines;
  PipelineDataReadyState(this.pipelines);
}

class PipelineDataBloc extends Bloc<PipelineDataEvent, PipelineDataState> {
  PipelineDataBloc() : super(PipelineDataState()) {
    on<PipelineDataReadEvent>(_readData);
  }

  void _readData(PipelineDataReadEvent event, Emitter emit) async {
    var data = await PipelineDataProvider.readData();
    emit(PipelineDataReadyState(data));
  }
}