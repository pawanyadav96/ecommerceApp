import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {

  Future<String> getAddress() async {

    bool serviceEnabled =
    await Geolocator
        .isLocationServiceEnabled();

    if (!serviceEnabled) {

      return "GPS Disabled";
    }

    LocationPermission permission =
    await Geolocator.checkPermission();

    // Denied
    if (permission ==
        LocationPermission.denied) {

      permission =
      await Geolocator
          .requestPermission();

      if (permission ==
          LocationPermission.denied) {

        return "Permission Denied";
      }
    }

    // Permanent denied
    if (permission ==
        LocationPermission.deniedForever) {

      return
        "Permission Permanently Denied";
    }

    Position position =
    await Geolocator.getCurrentPosition(
      desiredAccuracy:
      LocationAccuracy.high,
    );

    List<Placemark> placemarks =
    await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark place = placemarks.first;

    return
      "${place.locality}, "
          "${place.administrativeArea}, "
          "${place.country}";
  }
}