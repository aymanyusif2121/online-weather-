import 'package:geolocator/geolocator.dart';

class Location {
  double longtitude = 0;
  double latitude = 0;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      latitude = position.latitude;
      longtitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
