import 'package:bloc/bloc.dart';
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
      yield WeatherLoadInProgress();
      try {
        final CurrentWeather cur = await Api.getCurrentWeather();
        final List<HourlyWeather> hou = await Api.getHourlyWeather();
        yield WeatherLoadSuccess(cur, hou);
      } catch (_) {
        yield WeatherLoadFailure();
      }
    }
  }
}