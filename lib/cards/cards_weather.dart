import 'package:flutter/material.dart';
import 'package:weather_app/data/current_weather.dart';

class CardsWeather extends StatefulWidget {
  CurrentWeather currentWeather;

  CardsWeather(this.currentWeather);

  @override
  State<StatefulWidget> createState() => _CardsWeatherPage();
}

class _CardsWeatherPage extends State<CardsWeather> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.currentWeather.time.hour.toString() +
                    ':' +
                    widget.currentWeather.time.minute.toString(),
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
                '${widget.currentWeather.temperature}',
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
