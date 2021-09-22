import 'package:flutter/material.dart';
import 'package:weather_app/data/hourly_weather.dart';

class CardHourlyWeather extends StatelessWidget {
  HourlyWeather _hourlyWeather;

  CardHourlyWeather(this._hourlyWeather);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      child: Padding(
        padding: _hourlyWeather.position == ""
            ? EdgeInsets.only(bottom: 16.0)
            : _hourlyWeather.position == "L"
                ? EdgeInsets.only(left: 16.0, bottom: 16)
                : _hourlyWeather.position == "R"
                    ? EdgeInsets.only(right: 16.0, bottom: 16)
                    : EdgeInsets.only(bottom: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: _hourlyWeather.position == "L"
                ? BorderRadius.only(bottomLeft: Radius.circular(10))
                : _hourlyWeather.position == "R"
                    ? BorderRadius.only(bottomRight: Radius.circular(10))
                    : null,
          ),
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
