import 'package:flutter/material.dart';
import 'dart:core';
import 'package:screen/screen.dart';
import './themes/classic.dart';
import './themes/week.dart';

void main() {
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
      initialRoute: '/clocks/classic',
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => new Classic(),
        '/clocks/classic': (BuildContext context) => new Classic(),
        '/clocks/week': (BuildContext context) => new Week()
      },
    );
  }
}
