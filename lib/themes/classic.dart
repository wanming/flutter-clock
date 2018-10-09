import 'package:flutter/material.dart';
import '../theme_base.dart';
import '../common.dart';

class Classic extends ClockBaseStatefulWidget {
  Classic({Key key}) : super(key: key);

  @override
  _ClassicState createState() {
    var state = new _ClassicState();
    state.startClock();
    return state;
  }
}

class _ClassicState extends ClockBaseState<Classic> {
  _ClassicState() : super();

  @override
  Widget build(BuildContext context) {
    var _nowStyle = new TextStyle(
        fontSize: getDeviceSize(context).height * 0.4,
        color: Colors.white,
        fontFamily: 'UbuntuMono');
    return GestureDetector(
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/clocks/week', (_) => false);
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${_getTimeString(now)}', style: _nowStyle)
              ],
            ),
          ),
        ));
  }

  String _getTimeString(now) {
    return '${pad0(now.hour)}:${pad0(now.minute)}:${pad0(now.second)}';
  }
}
