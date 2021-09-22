import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/cards/card_weather.dart';
import 'package:weather_app/cards/cards_hourly_weather.dart';
import 'package:weather_app/delegates/search_delegate.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/states/weather_state.dart';

class MainPage extends StatelessWidget {

  MainPage();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColorDark: Colors.white,
        primaryColor: Colors.white,
      ),
      home: MainView(),
    );
  }
}

class MainView extends StatefulWidget {
  MainView();
  @override
  State<StatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoadSuccess) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                actions: [
                  IconButton(
                    icon: Icon(Icons.my_location),
                    onPressed: () {
                      BlocProvider.of<WeatherBloc>(context)
                          .add(WeatherCurrentPositionRequested());
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.search_outlined),
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: MySearchDelegate((query) {
                            BlocProvider.of<WeatherBloc>(context)
                                .add(WeatherRequested(city: query));
                          }));
                    },
                  ),
                ],
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${state.currentWeather.name}',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${state.currentWeather.description}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    CardWeather(state.currentWeather),
                    Spacer(),
                    CardsHourlyWeather(state.hourlyWeather, state.numbers),
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color.fromRGBO(0, 0, 0, 0),
              actions: [
                IconButton(
                  icon: Icon(Icons.my_location),
                  onPressed: () {
                    BlocProvider.of<WeatherBloc>(context)
                        .add(WeatherCurrentPositionRequested());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.search_outlined),
                  onPressed: () {
                    showSearch(
                        context: context,
                        delegate: MySearchDelegate((query) {
                          BlocProvider.of<WeatherBloc>(context)
                              .add(WeatherRequested(city: query));
                        }));
                  },
                ),
              ],
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
