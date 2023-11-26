import 'dart:js_interop';

import 'package:dxf/dxf.dart';
import 'package:flutter/material.dart';


class Graph extends CustomPainter {
  DXF? _dxf;
  var scale = 3000;
  double maxX = -1;
  double maxY = -1;
  double minX = double.infinity;
  double minY = double.infinity;

  Graph(this._dxf) {
    if (_dxf == null) {
      return;
    }
    for (var e in _dxf!.entities) {
      if (e is AcDbCircle) {
        if (e.x > maxX) {
          maxX = e.x;
        }
        if (e.y > maxY) {
          maxY = e.y;
        }
        if (e.x < minX) {
          minX = e.x;
        }
        if (e.y < minY) {
          minY = e.y;
        }         
      }
    }
    print("x: $maxX, y: $maxY, mx: $minX, my: $minY");
  }

  Offset scaleCoords(double x, double y) {
    var xWidth = maxX - minX;
    var yWidth = maxY - minY;
    return Offset((x - minX) / xWidth * scale, (y - minY) / yWidth * scale);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (_dxf == null) {
      return;
    }

    var rect = Offset.zero & Size(500, 500);
    var bgPaint = Paint()..color = Colors.blue;
    canvas.drawRect(rect, bgPaint);

    var paint = Paint()..color = Colors.red;
    for (var e in _dxf!.entities) {
      if (e is AcDbCircle) {
        canvas.drawCircle(scaleCoords(e.x, e.y), 0.01 * e.radius, paint);
        print("Circ: ${scaleCoords(e.x, e.y)}, ${0.01 * e.radius}");
      }
      else if (e is AcDbPolyline) {
        for (var i = 0; i < e.vertices.length - 1; i++) {
          var x1 = e.vertices[i][0];
          var y1 = e.vertices[i][1];
          var x2 = e.vertices[i+1][0];
          var y2 = e.vertices[i+1][1];
          canvas.drawLine(
            scaleCoords(x1, y1),
            scaleCoords(x2, y2), 
            paint
          );
        }
        if (e.isClosed) {
          var x1 = e.vertices.last[0];
          var y1 = e.vertices.last[1];
          var x2 = e.vertices.first[0];
          var y2 = e.vertices.first[1];
          canvas.drawLine(
            scaleCoords(x1, y1),
            scaleCoords(x2, y2), 
            paint
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(Graph oldDelegate) => false;  
}
