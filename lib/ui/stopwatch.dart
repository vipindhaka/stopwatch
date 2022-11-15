import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stopwatch/ui/reset_button.dart';
import 'package:stopwatch/ui/start_stop_button.dart';
import 'package:stopwatch/ui/stopwatch_renderer.dart';
import './elapsed_time_basic.dart';

class Stopwatch extends StatefulWidget {
  const Stopwatch({Key? key}) : super(key: key);

  @override
  _StopwatchState createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch>
    with SingleTickerProviderStateMixin {
  //late DateTime _initialTime;
  Duration _previouslyElapsed = Duration.zero;
  Duration _currentlyElapsed = Duration.zero;
  Duration get _elapsed => _previouslyElapsed + _currentlyElapsed;
  //late final Timer _timer;
  late final Ticker _ticker;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    //_initialTime = DateTime.now();
    _ticker = createTicker((elapsed) {
      //final now = DateTime.now();
      setState(() {
        //_elapsed = now.difference(_initialTime);
        _currentlyElapsed = elapsed;
      });
    });
    // _ticker.start();
  }

  void _toggleStartStop() {
    setState(() {
      _isRunning = !_isRunning;
      _ticker.isTicking ? _ticker.stop() : _ticker.start();
      _previouslyElapsed += _currentlyElapsed;
      _currentlyElapsed = Duration.zero;
    });
  }

  void _resetWatch() {
    setState(() {
      _isRunning = false;
      _ticker.stop();
      _previouslyElapsed = Duration.zero;
      _currentlyElapsed = Duration.zero;
    });
  }

  @override
  void dispose() {
    //_timer.cancel();
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final radius = constraints.maxWidth / 2;
        //print(radius);
        return Stack(
          children: [
            StopwatchRenderer(
              elapsed: _elapsed,
              radius: radius,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                height: 80,
                width: 80,
                child: ResetButton(
                    onPressed: _isRunning || _previouslyElapsed > Duration.zero
                        ? _resetWatch
                        : null),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                  height: 80,
                  width: 80,
                  child: StartStopButton(
                    isRunning: _isRunning,
                    onPressed: _toggleStartStop,
                  )),
            ),
          ],
        );
      },
    );
  }
}
