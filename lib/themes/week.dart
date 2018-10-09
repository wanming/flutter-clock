import 'package:flutter/material.dart';
import '../theme_base.dart';
import '../common.dart';

class Week extends ClockBaseStatefulWidget {
  Week({Key key}) : super(key: key);

  @override
  _WeekState createState() {
    var state = new _WeekState();
    state.startClock();
    return state;
  }
}

class _WeekState extends ClockBaseState<Week> {
  _WeekState() : super();

  @override
  Widget build(BuildContext context) {
    var deviceWith = getDeviceSize(context).height;
    var _timeStyle = new TextStyle(
        fontSize: deviceWith * 0.4, color: Color.fromARGB(255, 240, 240, 240));
    var _dateStyle = new TextStyle(
        fontSize: deviceWith * 0.08, color: Color.fromARGB(255, 194, 194, 194));
    var _weatherStyle = new TextStyle(
        fontSize: deviceWith * 0.08, color: Color.fromARGB(255, 194, 194, 194));
    return GestureDetector(
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/clocks/classic', (_) => false);
        },
        child: Scaffold(
            body: new Container(
          padding: EdgeInsets.fromLTRB(_timeStyle.fontSize / 2, 0.0, 0.0, 0.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                padding:
                    EdgeInsets.fromLTRB(_dateStyle.fontSize * 1, 0.0, 0.0, 0.0),
                child: Row(children: <Widget>[
                  new Text(
                      '${now.month}月${now.day}日，星期${ChineseWeekDays[now.weekday]}',
                      style: _dateStyle)
                ]),
              ),
              new Row(children: <Widget>[
                Text('${_getTimeString(now)}', style: _timeStyle),
              ]),
              new Container(
                padding:
                    EdgeInsets.fromLTRB(_dateStyle.fontSize * 1, 0.0, 0.0, 0.0),
                child: Row(children: <Widget>[
                  new Text('晴，20~30°C', style: _weatherStyle)
                ]),
              ),
            ],
          ),
        )));
  }

  String _getTimeString(now) {
    return '${pad0(now.hour)}:${pad0(now.minute)}:${pad0(now.second)}';
  }
}
