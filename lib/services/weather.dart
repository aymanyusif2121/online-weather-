import 'package:weather_clime/services/networking.dart';

import 'location.dart';

const apiKey = '9d03a8bdf78786da5b0cc58a0a171d6c';

class WeatherModel {
  Future<dynamic> getCityLocation(String city) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getWeatherLocation() async {
    try {
      Location location = Location();
      await location.getCurrentLocation();

      NetworkHelper networkHelper = NetworkHelper(
          'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longtitude}&appid=$apiKey');

      var weatherData = await networkHelper.getData();
      return weatherData;
    } on Exception catch (e) {
      print(e);
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }
}
