import '../errors/exception.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Future getCurrentLocationPermissions() async {
  bool serviceEnabled;
  LocationPermission permission;

  /// Return a boolean to know if the Location Service is enabled
  /// or if the user manually deactivated it.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  debugPrint('getCurrentLocationPermissions --> isLocationServiceEnabled --> $serviceEnabled');
  if (!serviceEnabled) {
    /// Location services are not enabled don't continue
    /// accessing the position and request users of the
    /// App to enable the location services.
    debugPrint('getCurrentLocationPermissions --> Location services are not enabled');
    throw NoPermission();
  } else {
    permission = await Geolocator.checkPermission();
    debugPrint('getCurrentLocationPermissions --> checkPermission --> $permission');
    if (permission == LocationPermission.denied || permission == LocationPermission.unableToDetermine) {
      permission = await Geolocator.requestPermission();
      debugPrint('getCurrentLocationPermissions --> Selected Location Permission Status --> $permission');
    } else if (permission == LocationPermission.deniedForever) {
      debugPrint('getCurrentLocationPermissions --> Sorry! Permission is Denied Forever');
      throw NoPermission();
    }
  }
}
