import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_clime/screens/location_screen.dart';

import 'package:weather_clime/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    var weatherData = await WeatherModel().getWeatherLocation();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LocationScreen(
                locationWeather: weatherData,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitRotatingCircle(
          size: 100.0,
          color: Colors.grey,
        ),
      ),
    );
  }
}
