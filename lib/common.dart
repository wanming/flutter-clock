import 'package:location/location.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const CLOCK_INTERVAL = Duration(microseconds: 1000);

String pad0(int num) {
  if (num < 10) {
    return '0${num.toString()}';
  }
  return num.toString();
}

const ChineseWeekDays = <int, String>{
  1: '一',
  2: '二',
  3: '三',
  4: '四',
  5: '五',
  6: '六',
  7: '日',
};

Future<List<double>> getLocation() async {
  var location = new Location();
  var currentLocation = await location.getLocation();
  return [currentLocation['longitude'], currentLocation['latitude']];
}

const BASE_URL =
    'https://free-api.heweather.com/s6/weather/forecast?key=7d5df9c2d3d94216b631f1ff4c277b5f&location=';
Future<Map<String, String>> getWeather(List<double> location) async {
  var url = '$BASE_URL${location[0]},${location[1]}';
  var response = await http.get(url);
  Map body = json.decode(response.body);
  // TODO: Use cond_text_n if is in night.
  var weather = '${body['HeWeather6'][0]['daily_forecast'][0]['cond_txt_d']}';
  var high = '${body['HeWeather6'][0]['daily_forecast'][0]['tmp_max']}';
  var low = '${body['HeWeather6'][0]['daily_forecast'][0]['tmp_min']}';
  return <String, String>{'weather': weather, 'high': high, 'low': low};
}

Future<String> getWeatherString() async {
  // var location = await getLocation();
  // var weather = await getWeather(location);
  var weather = await getWeather([114.31, 30.52]);
  return '${weather['weather']}，${weather['low']}~${weather['high']}°C';
}
