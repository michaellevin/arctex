import 'package:flutter/material.dart';

enum PPParamType {
  string,
  int,
  double,
  bool,
  date,
  time,
  datetime,
  list,
  map,
}

class PPParamWidget extends StatelessWidget {
  final PPParamType type;
  final String label;
  final String value;

  const PPParamWidget({
    required this.type, 
    required this.label,
    required this.value,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ),
          SizedBox(
            width: 500,
            height: 50,
            child: TextField(
              enabled: false,
              expands: true,
              maxLines: null,
              minLines: null,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: value,
              ),
            ),
          )
        ]
      ),
    );
  }
}