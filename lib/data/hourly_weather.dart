class HourlyWeather {
  int temperature;
  String iconCode;
  String description;
  DateTime time;
  String position = "";

  HourlyWeather({
    required this.temperature,
    required this.iconCode,
    required this.description,
    required this.time,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      temperature: double.parse(json['main']['temp'].toString()).toInt(),
      iconCode: json['weather'][0]['icon'],
      description: json['weather'][0]['main'],
      time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }
}
