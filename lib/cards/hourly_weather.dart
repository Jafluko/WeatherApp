import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/cards/cards_weather.dart';
import 'package:weather_app/data/current_weather.dart';

class CardsHourlyWeather extends StatelessWidget {
  final List<CurrentWeather> hourlyWeather;

  const CardsHourlyWeather(this.hourlyWeather);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hourlyWeather.length,
        itemBuilder: (context, i) {
          return CardsWeather(hourlyWeather[i]);
        },
      ),
    );
  }
}