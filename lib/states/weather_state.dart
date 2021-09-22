import 'package:equatable/equatable.dart';
import 'package:weather_app/data/current_weather.dart';
import 'package:weather_app/data/hourly_weather.dart';
import 'package:weather_app/data/save_numbers.dart';

class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoadInProgress extends WeatherState {}

class WeatherLoadSuccess extends WeatherState {
  final CurrentWeather currentWeather;
  final List<HourlyWeather> hourlyWeather;
  final List<SaveNumbers> numbers;

  const WeatherLoadSuccess(this.currentWeather, this.hourlyWeather, this.numbers);

  @override
  List<Object> get props => [currentWeather, hourlyWeather, numbers];
}

class WeatherLoadFailure extends WeatherState {}