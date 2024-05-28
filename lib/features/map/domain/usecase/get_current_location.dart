import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../../core/errors/failures.dart';
import '../repository/current_location_repository.dart';

/// Get current location from the device
class GetCurrentLocation implements UseCase<Position, NoParams> {
  final CurrentLocationRepository currentLocationRepository;

  const GetCurrentLocation({
    required this.currentLocationRepository,
  });

  @override
  Future<Either<Failure, Position>> call(NoParams param) async {
    return await currentLocationRepository.getCurrentLocation();
  }
}
