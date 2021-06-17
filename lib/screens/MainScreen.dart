import 'package:WeatherApp/models/Weather.dart';
import 'package:WeatherApp/models/WeatherDaily.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/date_symbol_data_local.dart';

class MainScreen extends StatelessWidget {
  final Weather weather;
  final List<Weather> hourlyWeather;
  final List<WeatherDaily> dailyWeather;

  const MainScreen(
      {Key key, this.weather, this.hourlyWeather, this.dailyWeather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
      Text(
        weather.cityName,
        style: TextStyle(
            fontSize: 32,
            color: Colors.white70,
            fontWeight: FontWeight.bold),),
      Stack(children: [                                                                   // информация о погоде
        Container(
          height: 135,
          decoration: BoxDecoration(
              color: Colors.transparent.withOpacity(0.5),
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
        ),
        Container(
            height: 130.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                      Text('${weather.temperature}°C',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          )),
                      Text('${getDate(weather.dt)} ${getDay(weather.dt)}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          )),
                    ])),
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 23,),
                          Text('Ощущается:', style: TextStyle(color: Colors.white70, fontSize: 15,)),
                          Text('${weather.feels}°C', style: TextStyle(color: Colors.white70, fontSize: 15,)),
                          SizedBox(height: 25,),
                          Text('Влажность:', style: TextStyle(color: Colors.white70, fontSize: 15,)),
                          Text('${weather.humidity} %', style: TextStyle(color: Colors.white70, fontSize: 15,)),
                        ],
                )),
                Expanded(
                    child: Column(children: [
                  Image.network("http://openweathermap.org/img/wn/${weather.iconCode}@2x.png", scale: 1.2,),
                  Text(
                    weather.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15, color: Colors.white70),),
                ])),
              ],
            )),
      ]),
      SizedBox(height: 15),
      Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),                          // погода по часам
          height: 140,
          decoration: BoxDecoration(
              color: Colors.transparent.withOpacity(0.5),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    Text(
                      '${hourlyWeather[i].temperature.toInt()}°C',
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15, color: Colors.white70),),
                    Image.network("http://openweathermap.org/img/wn/${hourlyWeather[i].iconCode}@2x.png", scale: 1.3,),
                    Text(
                      '${hourlyWeather[i].time.hour}:${hourlyWeather[i].time.minute}0',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Colors.white70),
                    ),
                  ],
                );
              })),
      SizedBox(height: 15),
      Expanded(
          child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                  color: Colors.transparent.withOpacity(0.5),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: ListView.builder(
                  padding: const EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 0),
                  itemCount: dailyWeather.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Container(
                        child: Row(
                            children: [
                                Expanded(
                                    child: Text(
                                  "${getDate(dailyWeather[i].dt)} ${getDay(dailyWeather[i].dt)}",
                                      textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                )),
                                Expanded(
                                  child: Image.network("http://openweathermap.org/img/wn/${dailyWeather[i].iconCode}@2x.png", scale: 1,),
                                ),
                                Expanded(
                                    child: Text(
                                  "${dailyWeather[i].temp} °C",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontSize: 25, color: Colors.white),
                                )),
                              ]
                        ));
                  })))
    ]);
  }
}

String getDay(int i) {
  initializeDateFormatting('ru_RU', null);
  var date = new DateTime.fromMillisecondsSinceEpoch(i * 1000);
  var formatter = new DateFormat.E("ru");
  return formatter.format(date);
}
String getDate(int i) {
  initializeDateFormatting('ru_RU', null);
  var date = new DateTime.fromMillisecondsSinceEpoch(i * 1000);
  var formatter = new DateFormat.MMMd("ru");
  return formatter.format(date);
}
