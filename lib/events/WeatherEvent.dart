import 'package:WeatherApp/services/API.dart';
import 'package:equatable/equatable.dart';


abstract class WeatherEvent extends Equatable {       /// событие для того, чтобы BLoC понимал
                                                    /// что необходимо запрашивать данные о погоде по названию города.
  const WeatherEvent([List props = const []]);
}

class WeatherCurrentPositionRequested extends WeatherEvent {
  const WeatherCurrentPositionRequested() : super();

  @override
  List<Object> get props => [];
}

class WeatherRequested extends WeatherEvent {
  final String city;
  final String lat;
  final String lon;

  const WeatherRequested({
    this.city = "",
    this.lat = "" ,
    this.lon = ""})
      : super();

  @override
  List<Object> get props => [city];
}
