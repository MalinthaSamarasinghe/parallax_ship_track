import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/blocs/event_transformer.dart';
import '../../../domain/usecase/get_current_location.dart';

part 'current_location_event.dart';
part 'current_location_state.dart';

class CurrentLocationBloc extends Bloc<CurrentLocationEvent, CurrentLocationState> {
  final GetCurrentLocation getCurrentLocation;

  CurrentLocationBloc({required this.getCurrentLocation}) : super(const CurrentLocationState()) {
    on<CurrentLocationRequested>(_currentLocationRequested, transformer: Transformer.throttleDroppable());
  }

  FutureOr<void> _currentLocationRequested(CurrentLocationRequested event, Emitter<CurrentLocationState> emit) async {
    Either<Failure, Position> result = await getCurrentLocation(NoParams());

    result.fold(
      (failure) {
        String message = '';
        if(failure is DeviceFailure) {
          message = failure.message;
        } else if(failure is NoPermissionFailure) {
          message = 'No permission granted!';
        } else {
          message = 'Something went wrong. Please try again later!';
        }
        emit(state.copyWith(
          status: CurrentLocationStatus.failure,
          failureMessage: message,
        ));
      },
      (data) {
        emit(state.copyWith(
          status: CurrentLocationStatus.success,
          currentLocationData: data,
        ));
      },
    );
  }
}
