import 'package:flutter/material.dart';
import 'package:taegukgi/taegukgi/taegukgi_painter.dart';

class Taegukgi extends StatelessWidget {
  const Taegukgi({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: LayoutBuilder(
        builder: (context, constraints) => DecoratedBox(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: CustomPaint(
            size: Size(constraints.maxWidth, constraints.maxHeight),
            painter: TaegukgiPainter(),
          ),
        ),
      ),
    );
  }
}
