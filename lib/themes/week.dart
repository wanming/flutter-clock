import 'package:flutter/material.dart';
import '../theme_base.dart';
import '../common.dart';
import 'dart:async';

class Week extends ClockBaseStatefulWidget {
  Week({Key key}) : super(key: key);

  @override
  _WeekState createState() {
    var state = new _WeekState();
    state.startClock();
    state.startFetchWeather();
    return state;
  }
}

class _WeekState extends ClockBaseState<Week> {
  _WeekState() : super();

  String weather = '';

  @override
  Widget build(BuildContext context) {
    var deviceWith = getDeviceSize(context).height;
    var timeStyle = new TextStyle(
        fontSize: deviceWith * 0.4, color: Color.fromARGB(255, 240, 240, 240));
    var dateStyle = new TextStyle(
        fontSize: deviceWith * 0.08, color: Color.fromARGB(255, 194, 194, 194));
    var weatherStyle = new TextStyle(
        fontSize: deviceWith * 0.08, color: Color.fromARGB(255, 194, 194, 194));
    return GestureDetector(
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/clocks/classic', (_) => false);
        },
        child: Scaffold(
            body: new Container(
          padding: EdgeInsets.fromLTRB(timeStyle.fontSize / 2, 0.0, 0.0, 0.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                padding:
                    EdgeInsets.fromLTRB(dateStyle.fontSize * 1, 0.0, 0.0, 0.0),
                child: Row(children: <Widget>[
                  new Text(
                      '${now.month}月${now.day}日，星期${ChineseWeekDays[now.weekday]}',
                      style: dateStyle)
                ]),
              ),
              new Row(children: <Widget>[
                Text('${_getTimeString(now)}', style: timeStyle),
              ]),
              new Container(
                padding:
                    EdgeInsets.fromLTRB(dateStyle.fontSize * 1, 0.0, 0.0, 0.0),
                child: Row(children: <Widget>[
                  new Text(weather, style: weatherStyle)
                ]),
              ),
            ],
          ),
        )));
  }

  startFetchWeather() async {
    var result = '正在获取天气信息..';
    setState(() => weather = result);

    try {
      result = await getWeatherString();
      setState(() => weather = result);
    } catch (e) {
      setState(() => weather = '获取天气信息失败');
    }
    
    new Timer(const Duration(hours: 1), () {
      startFetchWeather();
    });
  }

  String _getTimeString(now) {
    return '${pad0(now.hour)}:${pad0(now.minute)}:${pad0(now.second)}';
  }
}
