import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/api_weather/api.dart';
import 'package:weather_app/data/current_weather.dart';
import 'package:weather_app/data/hourly_weather.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/states/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  //final String? cityName;

  WeatherBloc() : super(WeatherState()) {
    add(WeatherRequested());
  }

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async*{
    if (event is WeatherRequested) {
      yield* _newWeatherRequested(event);
    }
    if (event is WeatherCurrentPositionRequested) {
      yield* _newWeatherCurrentPositionRequested();
    }
  }

  Stream<WeatherState> _newWeatherRequested(WeatherRequested event) async* {
    yield WeatherLoadInProgress();
    try {
      final CurrentWeather currentWeather = await Api.getCurrentWeather(
        query: event.city,
        lat: event.lat,
        lon: event.lon
      );
      print('${event.city} ${event.lat} ${event.lon}');
      final List<HourlyWeather> hourlyWeather = await Api.getHourlyWeather(
        query: event.city,
        lat: event.lat,
        lon: event.lon
      );
      yield WeatherLoadSuccess(currentWeather, hourlyWeather);
    } catch (e) {
      yield WeatherLoadFailure();
    }
  }

  Stream<WeatherState> _newWeatherCurrentPositionRequested() async* {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      Position? lastKnowPosition = await Geolocator.getLastKnownPosition();
      if (lastKnowPosition != null) {
        print('${lastKnowPosition.latitude.toString()} ${lastKnowPosition.longitude.toString()}');
        add(WeatherRequested(
          lat: lastKnowPosition.latitude.toString(),
          lon: lastKnowPosition.longitude.toString()
        ));
      } else {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        print('${position.latitude.toString()} ${position.longitude.toString()}');
        add(WeatherRequested(
          lat: position.latitude.toString(),
          lon: position.longitude.toString()
        ));
      }
    } else {
      await Geolocator.requestPermission();
      add(WeatherCurrentPositionRequested());
    }
  }
}