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
    var sizes = getSizes(context);
    var timeStyle = new TextStyle(
        fontFamily: 'OverpassMono',
        fontSize: sizes['time'],
        color: Color.fromARGB(255, 240, 240, 240));
    var dateStyle = new TextStyle(
        fontSize: sizes['date'], color: Color.fromARGB(255, 194, 194, 194));
    var weatherStyle = new TextStyle(
        fontSize: sizes['weather'], color: Color.fromARGB(255, 194, 194, 194));
    var colonStyle = new TextStyle(
        fontSize: sizes['time'],
        color: Color.fromARGB(now.second % 2 == 0 ? 200 : 120, 240, 240, 240));
    return GestureDetector(
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/clocks/classic', (_) => false);
        },
        child: Scaffold(
            body: new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                padding:
                    EdgeInsets.fromLTRB(dateStyle.fontSize * 4, 0.0, 0.0, 0.0),
                child: Row(children: <Widget>[
                  new Text(
                      '${now.month}月${now.day}日，星期${ChineseWeekDays[now.weekday]}',
                      style: dateStyle)
                ]),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text('${pad0(now.hour)}', style: timeStyle),
                Text(':', style: colonStyle),
                Text('${pad0(now.minute)}', style: timeStyle),
                Text(':', style: colonStyle),
                Text('${pad0(now.second)}', style: timeStyle),
              ]),
              new Container(
                padding:
                    EdgeInsets.fromLTRB(dateStyle.fontSize * 4, 0.0, 0.0, 0.0),
                child: Row(
                    children: <Widget>[new Text(weather, style: weatherStyle)]),
              ),
            ],
          ),
        )));
  }

  startFetchWeather() async {
    if (!mounted) {
      new Timer(const Duration(milliseconds: 100), () {
        startFetchWeather();
      });
      return;
    }
    var result = '正在获取天气信息..';
    setState(() => weather = result);
    try {
      result = await getWeatherString();
      setState(() => weather = result);
    } catch (e) {
      print('get weather error');
      print(e);
      setState(() => weather = '获取天气信息失败');
    }

    new Timer(const Duration(hours: 1), () {
      startFetchWeather();
    });
  }

  Map<String, double> getSizes(BuildContext context) {
    var ratio = 2.5;
    double fWidth = 0.0;
    double fHeight = 0.0;
    double leftPadding = 20.0;

    var deviceSize = getDeviceSize(context);
    var width = deviceSize.width;
    var height = deviceSize.height;

    if (width > height) {
      if (width / height > ratio) {
        fHeight = height;
        fWidth = fHeight * ratio;
        leftPadding = (width - fWidth) / 2;
      } else {
        fWidth = width;
        fHeight = fWidth / ratio;
      }
    } else {
      fWidth = width;
      fHeight = fWidth / ratio;
    }

    return <String, double>{
      'time': fHeight / 2.2,
      'weather': 30.0,
      'date': 30.0,
      'leftPadding': leftPadding
    };
  }

  String _getTimeString(now) {
    return '${pad0(now.hour)}:${pad0(now.minute)}:${pad0(now.second)}';
  }
}
