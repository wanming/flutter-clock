import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:screen/screen.dart';
import './themes/classic.dart';
import './themes/week.dart';

void main() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);
  Screen.keepOn(true);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Tom clock',
      theme: new ThemeData(
        canvasColor: Colors.black
      ),
      initialRoute: '/clocks/week',
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => new Classic(),
        '/clocks/classic': (BuildContext context) => new Classic(),
        '/clocks/week': (BuildContext context) => new Week()
      },
    );
  }
}
