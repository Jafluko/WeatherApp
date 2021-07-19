import 'package:flutter/material.dart';
import 'package:weather_app/data/hourly_weather.dart';

class CardHourlyWeather extends StatelessWidget {
  HourlyWeather _hourlyWeather;

  CardHourlyWeather(this._hourlyWeather);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${_hourlyWeather.time.hour}:${_hourlyWeather.time.minute}0',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.network(
                'http://openweathermap.org/img/wn/${_hourlyWeather.iconCode}@2x.png',
                scale: 2.0,
              ),
              Text(
                '${_hourlyWeather.temperature}°',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
