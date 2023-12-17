import 'package:arctex/models/pipesection_model.dart';
import 'package:arctex/widgets/pp_parameter_widget.dart';
import 'package:flutter/material.dart';

class PipesectionWidget extends StatelessWidget {
  final PipesectionModel model;

  const PipesectionWidget(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // PPParamWidget(paramCode: 1, model: model),
        Text(model.name),
      ],
    );
  }
}
