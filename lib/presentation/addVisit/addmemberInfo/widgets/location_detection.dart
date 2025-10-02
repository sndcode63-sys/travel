import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class LocationService {
  LocationService._();

  static Future<Map<String, dynamic>?> getCurrentLocationWithAddress() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      Get.snackbar("Location Disabled", "Please enable location service.");
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.openAppSettings();
        Get.snackbar("Permission Denied",
            "Location permission is required to continue.");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      Get.snackbar("Permission Denied",
          "Location permission is permanently denied. Please enable from settings.");
      return null;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    String address = "${placemarks.first.street}, ${placemarks.first.locality}, "
        "${placemarks.first.administrativeArea}, ${placemarks.first.country}";

    return {
      "position": position,
      "address": address,
    };
  }
}
