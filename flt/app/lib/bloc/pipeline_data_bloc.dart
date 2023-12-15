import 'package:arktech/models/itree_node_model.dart';
import 'package:arktech/tools/pipeline_data_provider.dart';
import 'package:bloc/bloc.dart';

class PipelineDataEvent {}
class PipelineDataReadEvent extends PipelineDataEvent {}
class PipelineDataAddEvent extends PipelineDataEvent {
  final AbsPipelineModel model;
  PipelineDataAddEvent(this.model);
}
class PipelineDataSelectEvent extends PipelineDataEvent {
  final AbsPipelineModel model;
  PipelineDataSelectEvent(this.model);
}

class PipelineDataState {}
class PipelineDataReadyState extends PipelineDataState {
  final List<AbsPipelineModel> pipelines;
  PipelineDataReadyState(this.pipelines);
}
class PipelineCreatedState extends PipelineDataState {
  final AbsPipelineModel pipeline;
  PipelineCreatedState(this.pipeline);
}
class PipelineSelectedState extends PipelineDataState {
  final AbsPipelineModel pipeline;
  PipelineSelectedState(this.pipeline);
}

class PipelineDataBloc extends Bloc<PipelineDataEvent, PipelineDataState> {
  PipelineDataBloc() : super(PipelineDataState()) {
    on<PipelineDataReadEvent>(_readData);
    on<PipelineDataAddEvent>(_addData);
    on<PipelineDataSelectEvent>(_selectData);
  }

  void _readData(PipelineDataReadEvent event, Emitter emit) async {
    var data = await PipelineDataProvider.readData();
    emit(PipelineDataReadyState(data));
  }

  void _addData(PipelineDataAddEvent event, Emitter emit) async {
    await PipelineDataProvider.addModel(event.model);
    emit(PipelineCreatedState(event.model));
  }

  void _selectData(PipelineDataSelectEvent event, Emitter emit) async {
    emit(PipelineSelectedState(event.model));
  }
}