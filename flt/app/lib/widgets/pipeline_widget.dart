import 'package:arktech/models/pipeline_model.dart';
import 'package:arktech/widgets/pp_parameter_widget.dart';
import 'package:flutter/material.dart';

class PipelineWidget extends StatelessWidget {
  final PipelineModel model;
  const PipelineWidget(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PPParamWidget(type: PPParamType.string, label: "Наименование трубопровода", value: model.name),
        PPParamWidget(type: PPParamType.string, label: "Тип прокладки трубопровод", value: model.name),
        PPParamWidget(type: PPParamType.string, label: "Трубопровод пригоден для проведения внутритрубной диагностики?", value: model.name),
        PPParamWidget(type: PPParamType.string, label: "Наличие ЭХЗ", value: model.name),
        PPParamWidget(type: PPParamType.string, label: "Тип ЭХЗ", value: model.name),
        PPParamWidget(type: PPParamType.string, label: "Стандарт проектирования трубопровода", value: model.name),
        PPParamWidget(type: PPParamType.string, label: "Наличие наружной изоляции", value: model.name),
        PPParamWidget(type: PPParamType.string, label: "Скорость коррозии проектная", value: model.name),
        PPParamWidget(type: PPParamType.string, label: "Дата ввода в эксплуатацию", value: model.name),
        PPParamWidget(type: PPParamType.string, label: "Температура проектная", value: model.name),
        PPParamWidget(type: PPParamType.string, label: "Температура рабочая", value: model.name),
        PPParamWidget(type: PPParamType.string, label: "Давление проектное", value: model.name),
        PPParamWidget(type: PPParamType.string, label: "Давление рабочее", value: model.name),
        PPParamWidget(type: PPParamType.string, label: "Расход проектный", value: model.name),
        PPParamWidget(type: PPParamType.string, label: "Расход рабочий", value: model.name),
      ],
    );
  }
}