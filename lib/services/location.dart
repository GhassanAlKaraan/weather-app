import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Location {
  late double latitude;
  late double longitude;
  late String? cityName;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      latitude = position.latitude;
      longitude = position.longitude;

      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      cityName = placemarks.first.locality;

      print(position);
      print("City Name: $cityName");
    } catch (e) {
      print(e);
    }
  }
}
