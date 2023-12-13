import 'dart:convert';
import 'package:arktech/bloc/pipeline_data_bloc.dart';
import 'package:arktech/widgets/map_widget.dart';
import 'package:arktech/widgets/sensor_graph_widget.dart';
import 'package:arktech/widgets/tree_widget.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}


class _AssetsPageState extends State<AssetsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PipelineDataBloc, PipelineDataState>(
      builder: (context, state) {
        if (state is! PipelineDataReadyState) {
          return const Center(child: CircularProgressIndicator());
        }

        return Row(
          children: [
            TreeWidget(state.pipelines),
            const Expanded(
              flex: 1,
              child: SensorDataWidget(),
            )
          ]
        );
      }
    );
  }
}