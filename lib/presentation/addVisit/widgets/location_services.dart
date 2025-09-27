import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationServices {
  LocationServices._();

  static Future<Map<String, dynamic>?> getCurrentLocationWithAddress() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      Get.snackbar("Location Disabled", "Please enable location service.");
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Permission Denied", "Location permission is required.",backgroundColor: Colors.green);
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
          "Permission Denied",
          "Location permission is permanently denied. Please enable from settings.",backgroundColor: Colors.red);
      await Geolocator.openAppSettings();
      return null;
    }

    // fetch position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // get address
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    String address =
        "${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}";

    return {"position": position, "address": address};
  }
}
