import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/cards/card_hourly_weather.dart';
import 'package:weather_app/cards/card_weather.dart';
import 'package:weather_app/data/current_weather.dart';
import 'package:weather_app/data/hourly_weather.dart';

class CardsHourlyWeather extends StatelessWidget {
  final List<HourlyWeather> hourlyWeather;

  const CardsHourlyWeather(this.hourlyWeather);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hourlyWeather.length,
        itemBuilder: (context, i) {
          return CardHourlyWeather(hourlyWeather[i]);
        },
      ),
    );
  }
}