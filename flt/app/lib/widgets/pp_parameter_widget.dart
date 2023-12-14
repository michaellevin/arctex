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
  final dynamic value;

  late final TextEditingController _controller;

  PPParamWidget({
    required this.type, 
    required this.label,
    required this.value,
    super.key
  }) {
    _controller = TextEditingController(text: value.toString());
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 400,
            height: 50,
            child: TextField(
              controller: _controller,
              enabled: false,
              expands: true,
              maxLines: null,
              minLines: null,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0),
                border: const OutlineInputBorder(),
                suffixText: "kg/m3  ",
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
              ),
            ),
          )
        ]
      ),
    );
  }
}