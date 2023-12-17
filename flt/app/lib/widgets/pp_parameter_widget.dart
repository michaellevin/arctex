import 'package:arctex/models/parameter_model.dart';
import 'package:arctex/models/pipeline_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PPParamWidget extends StatelessWidget {
  final PipelineModel model;
  final PipelineParameterCode paramCode;
  final bool editMode;
  late final ParameterModel _paramModel;
  late final TextEditingController _controller;

  PPParamWidget(
      {required this.paramCode,
      required this.model,
      this.editMode = false,
      super.key}) {
    _paramModel = model.getParameter(paramCode);
    _controller = TextEditingController(text: _paramModel.value.toString());
  }

  Widget _getWidget() {
    // suffixIcon: const Align(
    //   alignment: Alignment.centerRight,
    //   child: Padding(
    //     padding: EdgeInsets.all(1.0),
    //     child: Text(
    //       "kg/m3",
    //       // style: const TextStyle(fontWeight: FontWeight.bold),
    //     ),
    //   ),
    // ),
    //
    switch (_paramModel.type) {
      case PPParamType.bool:
        return Align(
          alignment: Alignment.centerLeft,
          child: Checkbox(
            value: _paramModel.value,
            onChanged: (value) => _onEdit(value),
          ),
        );
      case PPParamType.double:
        return TextField(
          controller: _controller,
          enabled: editMode,
          onChanged: (value) => _onEdit(value),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 10.0),
            border: const OutlineInputBorder(),
            suffixText: _paramModel.unit != null ? "${_paramModel.unit}  " : "",
          ),
        );
      case PPParamType.string:
        return TextField(
          controller: _controller,
          enabled: editMode,
          onChanged: (value) => _onEdit(value),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 10.0),
            border: const OutlineInputBorder(),
            suffixText: _paramModel.unit != null ? "${_paramModel.unit}  " : "",
          ),
        );
      case PPParamType.int:
        return TextField(
          controller: _controller,
          enabled: editMode,
          onChanged: (value) => _onEdit(value),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 10.0),
            border: const OutlineInputBorder(),
            suffixText: _paramModel.unit != null ? "${_paramModel.unit}  " : "",
          ),
        );
      // case PPParamType.enumType:
      //   return DropdownButton(
      //     value: _paramModel.value,
      //     onChanged: (value) => _onEdit(value),
      //     items: _paramModel.enumValues
      //         .map((e) => DropdownMenuItem(
      //               value: e,
      //               child: Text(e),
      //             ))
      //         .toList(),
      //   );
      case PPParamType.date:
        return TextField(
          controller: _controller,
          enabled: editMode,
          onChanged: (value) => _onEdit(value),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 10.0),
            border: const OutlineInputBorder(),
            suffixText: _paramModel.unit != null ? "${_paramModel.unit}  " : "",
          ),
        );
      default:
        return const Text("Unknown type");
    }
  }

  void _onEdit(dynamic value) {
    model.setParameter(paramCode, value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(children: [
        SizedBox(
            width: 200,
            child: Text(
              _paramModel.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
        const SizedBox(width: 10),
        SizedBox(
          width: 300,
          height: 50,
          child: _getWidget(),
        )
      ]),
    );
  }
}
