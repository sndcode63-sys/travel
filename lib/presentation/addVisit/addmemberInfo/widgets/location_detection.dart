import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationService {
  LocationService._();

  static Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Open location settings forcibly
      await Geolocator.openLocationSettings();
      Get.snackbar("Location Disabled", "Please enable location service.");
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Open app settings forcibly
        await Geolocator.openAppSettings();
        Get.snackbar("Permission Denied",
            "Location permission is required to continue.");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Open app settings forcibly
      await Geolocator.openAppSettings();
      Get.snackbar("Permission Denied",
          "Location permission is permanently denied. Please enable from settings.");
      return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
