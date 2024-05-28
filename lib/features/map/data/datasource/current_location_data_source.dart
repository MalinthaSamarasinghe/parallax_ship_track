import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/other/get_current_location_permissions.dart';

abstract class CurrentLocationDataSource {
  Future<Position> getCurrentLocation();
}

class CurrentLocationDataSourceImpl implements CurrentLocationDataSource {
  const CurrentLocationDataSourceImpl();

  @override
  Future<Position> getCurrentLocation() async {
    try {
      await getCurrentLocationPermissions();
      final currentPositionData = await Geolocator.getCurrentPosition();
      return currentPositionData;
    } catch (e) {
      debugPrint("Device location loading exception: $e");
      throw DeviceException(message: '$e');
    }
  }
}
