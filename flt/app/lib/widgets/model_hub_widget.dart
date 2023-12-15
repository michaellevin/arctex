import 'package:arktech/bloc/pipeline_data_bloc.dart';
import 'package:arktech/models/pipeline_model.dart';
import 'package:arktech/models/pipesection_model.dart';
import 'package:arktech/widgets/pipeline_widget.dart';
import 'package:arktech/widgets/pipesection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModelHubWidget extends StatefulWidget {
  const ModelHubWidget({super.key});

  @override
  State<ModelHubWidget> createState() => _ModelHubWidgetState();
}

class _ModelHubWidgetState extends State<ModelHubWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PipelineDataBloc, PipelineDataState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is PipelineSelectedState && state.pipeline is PipelineModel) {
          return PipelineWidget(state.pipeline as PipelineModel, false);
        }
        if (state is PipelineCreatedState && state.pipeline is PipelineModel) {
          return PipelineWidget(state.pipeline as PipelineModel, true);
        }
        if (state is PipelineSelectedState && state.pipeline is PipesectionModel) {
          return PipesectionWidget(state.pipeline as PipesectionModel);
        }
        
        return const Text('Select a pipeline');
      },
    );
  }
}