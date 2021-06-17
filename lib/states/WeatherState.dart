import 'package:WeatherApp/models/Weather.dart';
import 'package:WeatherApp/models/WeatherDaily.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherState extends Equatable {   /// состояния
  const WeatherState();

  @override
  List<Object> get props => [];
}

class Initial extends WeatherState {} /// не происходит ничего

class LoadInProgress extends WeatherState {}  /// когда мы загружаем данные о погоде

class LoadSuccess extends WeatherState {   ///  когда данные загружены успешно
  final Weather weather;
  final List<Weather> hourlyWeather;
  final List<WeatherDaily> dailyWeather;
  const LoadSuccess(
      {
        this.weather,
        this.hourlyWeather,
        this.dailyWeather,
      }
  ) : assert(weather != null),
      assert(hourlyWeather != null),
        assert(dailyWeather != null);
  /// проверяем чтобы все экземпляры класса не были равны нул

}

class LoadFail extends WeatherState {
}  /// когда произошла какая-то ошибка
