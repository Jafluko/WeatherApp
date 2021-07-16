import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/api_weather/api.dart';
import 'package:weather_app/cards/cards_weather.dart';
import 'package:weather_app/cards/hourly_weather.dart';
import 'package:weather_app/data/current_weather.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: MainView(),
    );
  }
}

class MainView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            FutureBuilder<CurrentWeather>(
              future: Api.getCurrentWeather(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CardsWeather(snapshot.data!);
                } else if (snapshot.hasError){
                  return Text(snapshot.error.toString());
                }
                return CircularProgressIndicator();
              },
            ),
            Spacer(),
            FutureBuilder<List<CurrentWeather>>(
              future: Api.getHourlyWeather(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CardsHourlyWeather(snapshot.data!);
                } else if (snapshot.hasError){
                  return Text(snapshot.error.toString());
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
