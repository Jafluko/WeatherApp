import 'package:equatable/equatable.dart';
import 'package:weather_app/data/current_weather.dart';
import 'package:weather_app/data/hourly_weather.dart';

class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoadInProgress extends WeatherState {}

class WeatherLoadSuccess extends WeatherState {
  final CurrentWeather currentWeather;
  final List<HourlyWeather> listHourly;

  const WeatherLoadSuccess(this.currentWeather, this.listHourly);

  @override
  List<Object> get props => [currentWeather, listHourly];
}

class WeatherLoadFailure extends WeatherState {}