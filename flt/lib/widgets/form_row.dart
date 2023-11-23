import 'package:flutter/material.dart';


enum RowType {text, radio, dropdown}


class FormRow extends StatelessWidget {
  String label;
  RowType type;

  FormRow(this.label, this.type, {super.key});

  Widget getField() {
    if (type == RowType.text) {
      return const TextField();
    }
    if (type == RowType.radio) {
      return Container(
        alignment: Alignment.centerLeft,
        child: Switch(
          value: false,
          onChanged: (state) {print("Changed switch!");},
        ),
      );
    }
    if (type == RowType.dropdown) {
      return DropdownMenu(
        width: 400,
        hintText: label,
        dropdownMenuEntries: [
          DropdownMenuEntry(value: 0, label: "Unburied"),
          DropdownMenuEntry(value: 1, label: "Buried"),
          DropdownMenuEntry(value: 2, label: "Subsea"),
        ]
      );
    }
    throw Exception("Uknown form row type: $type");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 400,
            child: getField(),
          ),
        ]
      ),
    );
  }
}