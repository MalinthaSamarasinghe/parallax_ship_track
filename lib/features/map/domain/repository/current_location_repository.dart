import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/errors/failures.dart';

abstract class CurrentLocationRepository {
  Future<Either<Failure, Position>> getCurrentLocation();
}
