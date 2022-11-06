import 'package:geolocator/geolocator.dart';

class LocationUtil {
  static Future<bool> isGeoLocationEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  static Future<bool> locationPermission() async {
    bool hasPermission = false;
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      } else if (permission == LocationPermission.deniedForever) {
        print('Location permissions are permanently denied');
      } else {
        print('GPS Location service is granted');
        hasPermission = true;
      }
    } else {
      print("GPS Location permission granted.");
      hasPermission = true;
    }
    return hasPermission;
  }

  static Future<Position> getCoordinates() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  static double getDistanceBetweenCoordinates(
      Position startPosition, Position destination) {
    double distance = Geolocator.distanceBetween(startPosition.latitude,
        startPosition.longitude, destination.latitude, destination.longitude);
    print("Distance: $distance");
    return distance;
  }
}
