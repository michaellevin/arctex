import 'package:arctex/models/mining_site_model.dart';
import 'package:arctex/widgets/pp_parameter_widget.dart';
import 'package:flutter/material.dart';

class MiningSiteWidget extends StatelessWidget {
  final MiningSiteModel model;
  const MiningSiteWidget(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      // child: Column(
      //   children: [
      //     PPParamWidget(type: PPParamType.string, label: "Pipeline name", value: model.name),
      //   ]
      // ),
    );
  }
}
