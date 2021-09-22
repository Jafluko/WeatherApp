import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/api_weather/api.dart';
import 'package:weather_app/data/current_weather.dart';
import 'package:weather_app/data/hourly_weather.dart';
import 'package:weather_app/data/save_numbers.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/states/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState()) {
    add(WeatherRequested());
  }

  Future<bool?> _getStateData() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool('isSave');
  }

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (event is WeatherRequested) {
      if (pref.getBool('isSave') == true) {
        yield* _weatherCurrentPositionSavedRequested();
      } else {
        yield* _newWeatherRequested(event);
      }
    }
    if (event is WeatherCurrentPositionRequested) {
      yield* _newWeatherCurrentPositionRequested();
    }
  }

  Stream<WeatherState> _newWeatherRequested(WeatherRequested event) async* {
    yield WeatherLoadInProgress();
    try {
      final CurrentWeather currentWeather = await Api.getCurrentWeather(
          query: event.city, lat: event.lat, lon: event.lon);
      print('${event.city} ${event.lat} ${event.lon}');
      final List<HourlyWeather> hourlyWeather = await Api.getHourlyWeather(
          query: event.city, lat: event.lat, lon: event.lon);

      yield WeatherLoadSuccess(
          currentWeather, hourlyWeather, _createList(hourlyWeather));
    } catch (e) {
      yield WeatherLoadFailure();
    }
  }

  List<SaveNumbers> _createList(List<HourlyWeather> list) {
    List<SaveNumbers> result = [];
    HashSet<int> setArray = HashSet();
    for (int i = 0; i < list.length; i++) {
      setArray.add(list[i].time.day);
    }
    var semList = setArray.toList();
    semList.sort();
    semList.forEach((item) {
      result.add(SaveNumbers(
        number: item.toString(),
        lengthContainer: list.where((element) => element.time.day == item).toList().length,
      ));
    });
    return result;
  }

  Stream<WeatherState> _newWeatherCurrentPositionRequested() async* {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position? lastKnowPosition = await Geolocator.getLastKnownPosition();
      if (lastKnowPosition != null) {
        setCoordinates(
            lat: lastKnowPosition.latitude.toString(),
            lon: lastKnowPosition.longitude.toString());
        add(WeatherRequested(
            lat: lastKnowPosition.latitude.toString(),
            lon: lastKnowPosition.longitude.toString()));
      } else {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        setCoordinates(
          lat: position.latitude.toString(),
          lon: position.longitude.toString(),
        );
        add(WeatherRequested(
          lat: position.latitude.toString(),
          lon: position.longitude.toString(),
        ));
      }
    } else {
      await Geolocator.requestPermission();
      add(WeatherCurrentPositionRequested());
    }
  }

  Stream<WeatherState> _weatherCurrentPositionSavedRequested() async* {
    SharedPreferences pref = await SharedPreferences.getInstance();
    yield* _newWeatherRequested(WeatherRequested(
        lat: pref.getString('latSave')!, lon: pref.getString('lonSave')!));
  }

  void setCoordinates({String lat = '', String lon = ''}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('latSave', lat);
    pref.setString('lonSave', lon);
    pref.setBool('isSave', true);
  }
}
