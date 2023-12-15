import 'package:arktech/bloc/pipeline_data_bloc.dart';
import 'package:arktech/models/pipeline_model.dart';
import 'package:arktech/widgets/pp_parameter_widget.dart';
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
    return Stack(
      children: [
        ListView(
          children: [
            PPParamWidget(paramCode: 1, model: widget.model, editMode: _editMode),
            PPParamWidget(paramCode: 2, model: widget.model, editMode: _editMode),
            PPParamWidget(paramCode: 3, model: widget.model, editMode: _editMode),
            PPParamWidget(paramCode: 4, model: widget.model, editMode: _editMode),
            PPParamWidget(paramCode: 5, model: widget.model, editMode: _editMode),
            PPParamWidget(paramCode: 6, model: widget.model, editMode: _editMode),
            PPParamWidget(paramCode: 7, model: widget.model, editMode: _editMode),
            PPParamWidget(paramCode: 8, model: widget.model, editMode: _editMode),
            // PPParamWidget(paramCode: 9, model: widget.model, editMode: _editMode),
            PPParamWidget(paramCode: 10, model: widget.model, editMode: _editMode),
            PPParamWidget(paramCode: 11, model: widget.model, editMode: _editMode),
            // PPParamWidget(paramCode: 12, model: widget.model, editMode: _editMode),
            PPParamWidget(paramCode: 13, model: widget.model, editMode: _editMode),
            // PPParamWidget(paramCode: 14, model: widget.model, editMode: _editMode),
            PPParamWidget(paramCode: 15, model: widget.model, editMode: _editMode),
            // PPParamWidget(paramCode: 16, model: widget.model, editMode: _editMode),
            PPParamWidget(paramCode: 17, model: widget.model, editMode: _editMode),
          ],
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Row(
            children: [
              _editMode ? IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: () => _setEditMode()
              ) : Container(),
              IconButton(
                icon: _editMode ? const Icon(Icons.save) : const Icon(Icons.edit),
                onPressed: _editMode ? () => _save() : () => _setEditMode()
              ),
            ],
          ),
        ),
      ]
    );
  }
}