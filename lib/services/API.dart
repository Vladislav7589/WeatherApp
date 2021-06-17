import 'dart:convert';
import 'package:WeatherApp/models/Weather.dart';
import 'package:WeatherApp/models/WeatherDaily.dart';
import 'package:http/http.dart' as http;



class API {                                                     // работа с API  OpenWeatherMap
  static String _apiKey = "a0588542012ed6d2d4e49d117fa1ae8a";

  static Future<Weather> fetchCurrentWeather({query, String lat = "" , String lon  = ""}) async { // получение текущей погоды

    // async - он синхронно выполняет код этого метода, пока не встретит первое ключевое слово await, после чего исполнение метода приостанавливается
    // пока Future, связанный с ключевым словом await будет завершён

    var url = 'https://api.openweathermap.org/data/2.5/weather?q=$query&lat=$lat&lon=$lon&appid=$_apiKey&units=metric&lang=ru';
    final response = await http.post(url);
      if (response.statusCode == 200) return Weather.fromJson(json.decode(response.body));
      else throw Exception('Failed to load weather');

  }

  static Future<List<Weather>> fetchHourlyWeather({String query, String lat = "" , String lon = ""}) async {   //получение погоды по часам

    var url = 'https://api.openweathermap.org/data/2.5/forecast?q=$query&lat=$lat&lon=$lon&appid=$_apiKey&units=metric&lang=ru';
    final response = await http.post(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Weather> data = (jsonData['list'] as List<dynamic>).map((item)
      {
        return Weather.fromJson(item);
      }).toList();
      return data;

    } else throw Exception('Failed to load weather');

  }
  static Future<List<WeatherDaily>> fetchDailyWeather({String query, String lat = "", String lon =""}) async {   //получение погоды по дням

    var url = 'https://api.openweathermap.org/data/2.5/forecast/daily?q=$query&lat=$lat&lon=$lon&appid=$_apiKey&units=metric&lang=ru';
    final response = await http.post(url);
    if (response.statusCode == 200) {

      final jsonData = json.decode(response.body);
      final List<WeatherDaily> data2 = (jsonData['list'] as List<dynamic>).map((item)
      {

        return WeatherDaily.fromJson(item);
      }).toList();
      return data2;
    } else throw Exception('Failed to load weather');

  }
}
