import 'dart:convert' as convert;
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/geo/geo.dart';

class Api {

  static final _apiKey = '64a9d7443852091981c81292c0aef453';
  static final _headUrl = 'http://api.openweathermap.org/data/2.5/weather?';

  static Future<String> getInfo() async {
    Position position = await Geo.determinePosition();
    print('lat: ' + position.latitude.toString());
    print('lon: ' + position.longitude.toString());
    var url = _headUrl + 'lat=${position.latitude}&lon=${position.longitude}&appid=$_apiKey';
    //var url = _headUrl + 'lat=54.35&lon=52.52&appid=$_apiKey';
    //var url = _headUrl + 'q=London&appid=$_apiKey';
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonView = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return jsonView['name'];
    } else {
      return '${response.statusCode}';
    }
  }
}