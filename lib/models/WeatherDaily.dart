
class WeatherDaily {
  final int temp;
  final String iconCode;
  final int dt;

  WeatherDaily({
    this.temp,
    this.dt,
    this.iconCode,
  });

  factory WeatherDaily.fromJson(Map<String, dynamic> json) {
    return WeatherDaily(
      temp: double.parse(json['temp']['day'].toString()).toInt(),
      iconCode: json['weather'][0]['icon'],
      dt: json['dt'].toInt(),
    );
  }
}

