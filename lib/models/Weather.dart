
class Weather {
  final String cityName;
  final int temperature;
  final String iconCode;
  final String description;
  final int feels;
  final int humidity;
  final DateTime time;
  final int dt;


  Weather({  this.cityName,
    this.temperature,
    this.iconCode,
    this.description,
    this.feels,
    this.humidity,
    this.time,
    this.dt,
});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: double.parse(json['main']['temp'].toString()).toInt(),
      iconCode: json['weather'][0]['icon'],
      description: json['weather'][0]['description'],
      feels: double.parse(json['main']['feels_like'].toString()).toInt(),
      humidity: double.parse(json['main']['humidity'].toString()).toInt(),
      time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      dt: json['dt'].toInt(),
    );
  }
}

