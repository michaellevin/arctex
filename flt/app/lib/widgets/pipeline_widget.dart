import 'package:arctex/bloc/pipeline_data_bloc.dart';
import 'package:arctex/models/pipeline_model.dart';
import 'package:arctex/widgets/pp_parameter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PipelineWidget extends StatefulWidget {
  final PipelineModel model;
  final bool editMode;
  const PipelineWidget(this.model, this.editMode, {super.key});

  @override
  State<PipelineWidget> createState() => _PipelineWidgetState();
}

class _PipelineWidgetState extends State<PipelineWidget> {
  bool _editMode = false;

  @override
  void initState() {
    super.initState();
    _editMode = widget.editMode;
  }

  void _setEditMode() {
    setState(() {
      _editMode = !_editMode;
    });
  }

  void _save() {
    setState(() {
      _editMode = false;
    });
    context.read<PipelineDataBloc>().add(PipelineDataAddEvent(widget.model));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView(
        children: [
          PPParamWidget(
              paramCode: PipelineParameterCode.pipelineName,
              model: widget.model,
              editMode: _editMode),
          PPParamWidget(
              paramCode: PipelineParameterCode.length,
              model: widget.model,
              editMode: _editMode),
          PPParamWidget(
              paramCode: PipelineParameterCode.startDate,
              model: widget.model,
              editMode: _editMode),
          PPParamWidget(
              paramCode: PipelineParameterCode.pipeworkMaterial,
              model: widget.model,
              editMode: _editMode),
          PPParamWidget(
              paramCode: PipelineParameterCode.materialStandard,
              model: widget.model,
              editMode: _editMode),
          PPParamWidget(
              paramCode: PipelineParameterCode.pipelineDesignStandard,
              model: widget.model,
              editMode: _editMode),
          PPParamWidget(
              paramCode: PipelineParameterCode.designCorrosionTolerance,
              model: widget.model,
              editMode: _editMode),
          PPParamWidget(
              paramCode: PipelineParameterCode.designLifeOfEquipment,
              model: widget.model,
              editMode: _editMode),
          PPParamWidget(
              paramCode: PipelineParameterCode.designCorrosionRate,
              model: widget.model,
              editMode: _editMode),
          PPParamWidget(
              paramCode: PipelineParameterCode.workingCorrosionRate,
              model: widget.model,
              editMode: _editMode),
          PPParamWidget(
              paramCode: PipelineParameterCode.designTemperature,
              model: widget.model,
              editMode: _editMode),
          PPParamWidget(
              paramCode: PipelineParameterCode.workingTemperature,
              model: widget.model,
              editMode: _editMode),
          PPParamWidget(
              paramCode: PipelineParameterCode.designPressure,
              model: widget.model,
              editMode: _editMode),
          PPParamWidget(
              paramCode: PipelineParameterCode.workingPressure,
              model: widget.model,
              editMode: _editMode),
          PPParamWidget(
              paramCode: PipelineParameterCode.nominalWallThickness,
              model: widget.model,
              editMode: _editMode),
          PPParamWidget(
              paramCode: PipelineParameterCode.minPermissibleWallThickness,
              model: widget.model,
              editMode: _editMode),
          PPParamWidget(
              paramCode: PipelineParameterCode.outerDiameter,
              model: widget.model,
              editMode: _editMode),
          PPParamWidget(
              paramCode: PipelineParameterCode.actualWallThickness,
              model: widget.model,
              editMode: _editMode),
        ],
      ),
      Positioned(
        bottom: 10,
        right: 10,
        child: Row(
          children: [
            _editMode
                ? IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () => _setEditMode())
                : Container(),
            IconButton(
                icon:
                    _editMode ? const Icon(Icons.save) : const Icon(Icons.edit),
                onPressed: _editMode ? () => _save() : () => _setEditMode()),
          ],
        ),
      ),
    ]);
  }
}
