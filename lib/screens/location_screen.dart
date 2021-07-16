import 'package:flutter/material.dart';
import 'package:weather_clime/constants.dart';
import 'package:weather_clime/screens/city_name.dart';
import 'package:weather_clime/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int? temperature;
  String? cityName;
  int? condition;
  String? tempratureMessage;
  String? weatherIcon;
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    if (weatherData == null) {
      temperature = 0;
      weatherIcon = 'unable';
      cityName = 'the location is disabled';
      return;
    }
    setState(() {
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt() - 273;

      condition = weatherData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition!);
      cityName = weatherData['name'];
      print(condition);
    });
  }

  stackImageColor() {
    if (temperature! > 25) {
      return {
        "image": AssetImage('images/fine.jpg'),
        "color": Colors.red.withOpacity(0.2)
      };
    } else if (temperature! >= 15 && temperature! <= 25)
      return {
        "image": AssetImage('images/cloudy.jpg'),
        "color": Colors.green.withOpacity(0.3)
      };
    else {
      return {
        "image": AssetImage('images/rainy.jpg'),
        "color": Colors.blue.withOpacity(0.3)
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: stackImageColor()["image"],
                  fit: BoxFit.cover,
                ),
              ),
              constraints: BoxConstraints.expand(),
              child: Container(
                color: stackImageColor()["color"],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          onPressed: () async {
                            var weatherData =
                                await weatherModel.getWeatherLocation();
                            updateUI(weatherData);
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.7),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Icon(
                              Icons.location_on,
                              size: 40.0,
                              color: Colors.white.withOpacity(1),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            var typedCityName = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CityScreen();
                                },
                              ),
                            );
                            print('$typedCityName kskjasajkajjas');
                            if (typedCityName != null) {
                              var weatherData = await weatherModel
                                  .getCityLocation(typedCityName);
                              updateUI(weatherData);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.7),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Icon(
                              Icons.location_city,
                              size: 40.0,
                              color: Colors.white.withOpacity(1),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '$temperature° ',
                              style: kTempTextStyle,
                            ),
                            Text(
                              '$weatherIcon',
                              style: kConditionTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 60, horizontal: 15),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: "$cityName",
                              style: TextStyle(
                                fontFamily: 'Spartan MB',
                                fontSize: 60.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                          TextSpan(text: "!", style: kMessageTextStyle),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
