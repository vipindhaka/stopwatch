import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stopwatch/ui/clock_hand.dart';
import 'package:stopwatch/ui/clock_markers.dart';
import 'package:stopwatch/ui/clock_text_marker.dart';
import 'package:stopwatch/ui/elapsed_time_text.dart';

import 'elapsed_time_basic.dart';

class StopwatchRenderer extends StatelessWidget {
  const StopwatchRenderer({
    required this.elapsed,
    required this.radius,
    Key? key,
  }) : super(key: key);

  final Duration elapsed;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (var i = 0; i < 60; i++)
          Positioned(
              left: radius,
              top: radius,
              child: ClockSecondsTickMarker(seconds: i, radius: radius)),
        // Container(
        //   decoration: BoxDecoration(
        //     border: Border.all(
        //       width: 3,
        //       color: Colors.orange,
        //     ),
        //     borderRadius: BorderRadius.circular(radius),
        //   ),
        // ),
        for (var i = 5; i <= 60; i += 5)
          Positioned(
            left: radius,
            top: radius,
            child: ClockTextMarker(seconds: i, maxValue: 60, radius: radius),
          ),
        Positioned(
          left: radius,
          top: radius,
          child: ClockHand(
            handThickness: 2.0,
            handLength: radius,
            rotationZAngle: pi + (2 * pi / 60000) * elapsed.inMilliseconds,
            color: Colors.orange,
          ),
        ),

        // Transform(
        //     transform: Matrix4.translationValues(100.0, 0.0, 0.0)
        //       ..rotateZ(pi / 4),
        //     // transform:
        //     //     Matrix4.translationValues(50, 0, 0) * Matrix4.rotationZ(pi / 4),
        //     alignment: Alignment.center,
        //     child: Container(color: Colors.indigo)),
        Positioned(
          left: 0,
          right: 0,
          top: radius * 1.3,
          child: ElapsedTimeText(
            elapsed: elapsed,
          ),
        ),
      ],
    );
  }
}
