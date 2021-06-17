import 'dart:async';

import 'package:WeatherApp/events/WeatherEvent.dart';
import 'package:WeatherApp/models/Weather.dart';
import 'package:WeatherApp/models/WeatherDaily.dart';
import 'package:WeatherApp/services/API.dart';
import 'package:WeatherApp/states/WeatherState.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {  ///WeatherEvent – события которые он будет обрабатывать
                                                              ///WeatherState – состояния в которых он может быть
  WeatherBloc() : super(null) {
    add(WeatherCurrentPositionRequested());   ///стандартное состояние
  }

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {   ///проверяем права на локацию, если прав нет, то просто запрашиваем.

    if (event is WeatherRequested) yield* _newWeatherRequested(event);
    if (event is WeatherCurrentPositionRequested) yield* _newWeatherCurrentPositionRequested();

  }

  Stream<WeatherState> _newWeatherRequested(WeatherRequested event) async* {
    yield LoadInProgress();
    try {
      final Weather weather = await API.fetchCurrentWeather(query: event.city, lon: event.lon, lat: event.lat);
      final List<Weather> hourlyWeather = await API.fetchHourlyWeather(query: event.city, lon: event.lon, lat: event.lat);
      final List<WeatherDaily> dailyWeather = await API.fetchDailyWeather(query: event.city, lon: event.lon, lat: event.lat);

      yield LoadSuccess(weather: weather, hourlyWeather: hourlyWeather, dailyWeather: dailyWeather);
    } catch (e) {
      yield LoadFail();
    }
  }

  Stream<WeatherState> _newWeatherCurrentPositionRequested() async* {              /// определение текущей локации
    LocationPermission permission = await checkPermission();
    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always)
    {
      Position lastKnownPosition = await getLastKnownPosition();
      if(lastKnownPosition != null) add(WeatherRequested(lat: lastKnownPosition.latitude.toString(), lon: lastKnownPosition.longitude.toString()));
      else {
        Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        add(WeatherRequested(lat: position.latitude.toString(), lon: position.longitude.toString()));
      }
    } else {
      await requestPermission();
      add(WeatherCurrentPositionRequested());
    }
  }
}
