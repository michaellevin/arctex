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
        PPParamWidget(type: PPParamType.string, label: "Тип прокладки трубопровод", value: model.cpType),
        PPParamWidget(type: PPParamType.string, label: "Трубопровод пригоден для проведения внутритрубной диагностики?", value: model.pigging),
        PPParamWidget(type: PPParamType.string, label: "Наличие ЭХЗ", value: model.cathodicProtection),
        PPParamWidget(type: PPParamType.string, label: "Тип ЭХЗ", value: model.cpType),
        PPParamWidget(type: PPParamType.string, label: "Стандарт проектирования трубопровода", value: model.pipelineDesignCode),
        PPParamWidget(type: PPParamType.string, label: "Наличие наружной изоляции", value: model.externalCoating),
        PPParamWidget(type: PPParamType.string, label: "Скорость коррозии проектная", value: model.designCorrosionRate),
        PPParamWidget(type: PPParamType.string, label: "Дата ввода в эксплуатацию", value: model.startDate),
        PPParamWidget(type: PPParamType.string, label: "Температура проектная", value: model.designTemperature),
        PPParamWidget(type: PPParamType.string, label: "Температура рабочая", value: 0),
        PPParamWidget(type: PPParamType.string, label: "Давление проектное", value: model.designPressure),
        PPParamWidget(type: PPParamType.string, label: "Давление рабочее", value: 0),
        PPParamWidget(type: PPParamType.string, label: "Расход проектный", value: model.designFlow),
        PPParamWidget(type: PPParamType.string, label: "Расход рабочий", value: 0),
      ],
    );
  }
}