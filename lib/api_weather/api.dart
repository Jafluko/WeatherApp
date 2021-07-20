import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:weather_app/data/current_weather.dart';
import 'package:weather_app/data/hourly_weather.dart';

class Api {
  static final _apiKey = '64a9d7443852091981c81292c0aef453';
  static final _headUrl = 'http://api.openweathermap.org/data/2.5';
  static final _sufUrl = '&units=metric';

  static Future<CurrentWeather> getCurrentWeather({String query = '', String lat = '', String lon = ''}) async {
    var url = _headUrl +
        '/weather?q=$query&lat=$lat&lon=$lon&appid=$_apiKey' +
        _sufUrl;
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonView = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return CurrentWeather.fromJson(jsonView);
    } else {
      throw Exception('Failed to load weather');
    }
  }

  static Future<List<HourlyWeather>> getHourlyWeather({String query = '', String lat = '', String lon = ''}) async {
    var url = _headUrl +
        '/forecast?q=$query&lat=$lat&lon=$lon&appid=$_apiKey' +
        _sufUrl;

    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = convert.jsonDecode(response.body);
      final List<HourlyWeather> data =
          (jsonData['list'] as List<dynamic>).map((item) {
        return HourlyWeather.fromJson(item);
      }).toList();
      print(data.length);
      return data;
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
