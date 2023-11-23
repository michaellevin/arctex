import 'package:arktech/widgets/form_row.dart';
import 'package:flutter/material.dart';


class L8CreationEntryForm extends StatefulWidget {
  const L8CreationEntryForm({super.key});

  @override
  State<L8CreationEntryForm> createState() => _L8CreationEntryFormState();
}

class _L8CreationEntryFormState extends State<L8CreationEntryForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Add Component',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        FormRow("Pipeline name", RowType.text),
        FormRow("Environment", RowType.dropdown),
        FormRow("Is pigging possible?", RowType.radio),
        FormRow("Is cathodic protection presented?", RowType.radio),
      ],
    );
  }
}