class CurrentWeather {
  final String name;
  final int temperature;
  final String iconCode;
  final String description;
  final DateTime time;

  CurrentWeather(
      {required this.name,
      required this.temperature,
      required this.iconCode,
      required this.description,
      required this.time});

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      name: json['name'],
      temperature: double.parse(json['main']['temp'].toString()).toInt(),
      iconCode: json['weather'][0]['icon'],
      description: json['weather'][0]['main'],
      time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }
}
