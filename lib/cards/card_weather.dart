import 'package:flutter/material.dart';
import 'package:weather_app/data/current_weather.dart';

class CardWeather extends StatefulWidget {
  CurrentWeather currentWeather;

  CardWeather(this.currentWeather);

  @override
  State<StatefulWidget> createState() => _CardWeatherPage();
}

class _CardWeatherPage extends State<CardWeather> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(0, 0, 0, 0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '${widget.currentWeather.time.hour}:${widget.currentWeather.time.minute < 10 ? 0 : ''}${widget.currentWeather.time.minute}',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.network(
                'http://openweathermap.org/img/wn/${widget.currentWeather.iconCode}@2x.png',
                scale: 1.0,
              ),
              Text(
                '${widget.currentWeather.temperature}°',
                style: TextStyle(
                  fontSize: 20.0,
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
