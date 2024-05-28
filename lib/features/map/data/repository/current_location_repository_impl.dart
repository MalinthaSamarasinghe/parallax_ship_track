import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../datasource/current_location_data_source.dart';
import '../../domain/repository/current_location_repository.dart';

class CurrentLocationRepositoryImpl implements CurrentLocationRepository {
  final CurrentLocationDataSource dataSource;

  const CurrentLocationRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, Position>> getCurrentLocation() async {
    try {
      final position = await dataSource.getCurrentLocation();
      return Right(position);
    } on DeviceException catch (exception) {
      return Left(DeviceFailure(message: exception.message));
    } on NoPermission catch (e) {
      debugPrint("#CurrentLocationRepositoryImpl --> NoPermission --> $e");
      return Left(NoPermissionFailure());
    }
  }
}
