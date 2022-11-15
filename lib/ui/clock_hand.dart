import 'package:flutter/material.dart';

class ClockHand extends StatelessWidget {
  final double handThickness;
  final double handLength;
  final double rotationZAngle;
  final Color color;

  const ClockHand({
    Key? key,
    required this.handThickness,
    required this.handLength,
    required this.rotationZAngle,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.topCenter,
      transform: Matrix4.identity()
        ..translate(-handThickness / 2, 0.0, 0.0)
        ..rotateZ(rotationZAngle),
      child: Container(
        height: handLength,
        width: handThickness,
        color: color,
      ),
    );
  }
}
