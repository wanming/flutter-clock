import 'package:flutter/material.dart';
import 'dart:async';
import './common.dart';

class ClockBaseStatefulWidget extends StatefulWidget {
  ClockBaseStatefulWidget({Key key}) : super(key: key);

  @override
  ClockBaseState createState() {
    var state = new ClockBaseState();
    state.startClock();
    return state;
  }
}

class ClockBaseState<T extends ClockBaseStatefulWidget> extends State {
  ClockBaseState(): super();

  DateTime now = DateTime.now();
  
  @override
  Widget build(BuildContext context) {
    return new Text('ClockBaseState is not implemented!');
  }

  startClock() {
    Timer.periodic(CLOCK_INTERVAL, (Timer t) {
      setState(() {
        now = DateTime.now();
      });
    });
  }

  Size getDeviceSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}
