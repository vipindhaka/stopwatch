import 'dart:math';

import 'package:flutter/material.dart';

class ClockTextMarker extends StatelessWidget {
  const ClockTextMarker({
    Key? key,
    required this.seconds,
    required this.maxValue,
    required this.radius,
  }) : super(key: key);
  final int seconds;
  final int maxValue;
  final double radius;
  @override
  Widget build(BuildContext context) {
    final height = 30.0;
    final width = 30.0;
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..translate(-width / 2, -height / 2, 0.0)
        ..rotateZ(pi + 2 * pi * (seconds / maxValue))
        ..translate(0.0, radius - height, 0.0)
        ..rotateZ(pi - 2 * pi * (seconds / maxValue)),
      child: Container(
        height: height,
        width: width,
        child: Text(
          seconds.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
