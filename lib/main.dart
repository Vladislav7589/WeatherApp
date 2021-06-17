import 'package:WeatherApp/delegates/Search.dart';
import 'package:WeatherApp/events/WeatherEvent.dart';
import 'package:WeatherApp/states/WeatherState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/WeatherBloc.dart';
import 'models/Weather.dart';
import 'models/WeatherDaily.dart';
import 'screens/MainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Weather weather;
  final List<Weather> hourlyWeather;
  final List<WeatherDaily> dailyWeather;
  const MyHomePage({Key key, this.weather, this.hourlyWeather, this.dailyWeather}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is LoadSuccess ) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(title: Text('Погода',style: TextStyle(
                  color: Colors.white60, fontSize: 25),),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                leading: IconButton(icon: Icon(Icons.my_location,size: 35, color: Colors.white60,),
                  onPressed: () {
                    BlocProvider.of<WeatherBloc>(context).add(WeatherCurrentPositionRequested());
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search, size: 40, color: Colors.white60),
                    onPressed: () {
                      showSearch(context: context, delegate: Search((query) {
                            BlocProvider.of<WeatherBloc>(context).add(WeatherRequested(city: query));
                      }));
                    },
                  )
                ],
              ),
              body: Container(
                child: Stack(
                  children: [
                    Image.asset("assets/day.jpeg", fit: BoxFit.cover, height: double.infinity, width: double.infinity,),
                    Container(decoration: BoxDecoration(color: Colors.black38),),
                Container(
                    padding: EdgeInsets.fromLTRB(20, 80, 20, 20),
                    child: MainScreen(weather: state.weather, hourlyWeather: state.hourlyWeather, dailyWeather: state.dailyWeather)
                    )
                  ],
                ),
              ),
            );
          } else {

          }


          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: Text('Погода',style: TextStyle(color: Colors.white60, fontSize: 25),),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.my_location,size: 35, color: Colors.white60,),
                onPressed: () {BlocProvider.of<WeatherBloc>(context).add(WeatherCurrentPositionRequested());},
              ),
              actions: [
                IconButton(     /// кнопка поиска
                  icon: Icon(Icons.search, size: 40, color: Colors.white60),
                  onPressed: () {showSearch(context: context, delegate: Search((query) {BlocProvider.of<WeatherBloc>(context).add(WeatherRequested(city: query));}));},
                )
              ],
            ),
            body: Container(
              child: Stack(
                children: [
                  Image.asset("assets/day.jpeg", fit: BoxFit.cover, height: double.infinity, width: double.infinity,),
                  Container(decoration: BoxDecoration(color: Colors.black38),),
                  Center(child: CircularProgressIndicator(),)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
