import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  final _text = TextEditingController();

  String? citySearchedName;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/city_background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (value) {
                      citySearchedName = value;
                      if (citySearchedName == null ||
                          citySearchedName!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: _text,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.location_city,
                        color: Colors.white,
                        size: 40,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      hintText: 'Enter city name ',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onFieldSubmitted: (value) {
                      citySearchedName = value;
                      Navigator.pop(context, citySearchedName);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context, citySearchedName);
                      },
                      child: Text(
                        'GET WEATHER ',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
