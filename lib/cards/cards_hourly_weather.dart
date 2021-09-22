import 'package:flutter/material.dart';
import 'package:weather_app/cards/card_hourly_weather.dart';
import 'package:weather_app/data/hourly_weather.dart';
import 'package:weather_app/data/save_numbers.dart';

class CardsHourlyWeather extends StatelessWidget {
  final List<HourlyWeather> hourlyWeather;
  final List<SaveNumbers> saveNumbers;

  TrackingScrollController _controller = TrackingScrollController();

  CardsHourlyWeather(this.hourlyWeather, this.saveNumbers);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _controller,
      child: Column(
        children: [
          Row(
            children: _setListNumbers(),
          ),
          Row(
            children: _setListWeather(),
          ),
        ],
      ),
    );
  }

  List<Widget> _setListNumbers() {
    List<Widget> result = [];
    for (int i = 0; i < saveNumbers.length; i++) {
      result.add(Container(
        height: 25,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
          child: Container(
            width: (80 * saveNumbers[i].lengthContainer - 32.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                saveNumbers[i].number,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ));
    }
    return result;
  }

  List<Widget> _setListWeather() {
    List<Widget> result = [];
    saveNumbers.forEach((item) {
      var flag = hourlyWeather.indexWhere((element) => element.time.day.toString() == item.number);
      hourlyWeather[flag].position = "L";
      flag = hourlyWeather.lastIndexWhere((element) => element.time.day.toString() == item.number);
      hourlyWeather[flag].position = "R";
    });

    for (int i = 0; i < hourlyWeather.length; i++) {
      result.add(Container(
        height: 120,
        child: CardHourlyWeather(hourlyWeather[i]),
      ));
    }
    return result;
  }
}
