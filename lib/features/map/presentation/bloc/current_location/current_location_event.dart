part of 'current_location_bloc.dart';

abstract class CurrentLocationEvent extends Equatable {
  const CurrentLocationEvent();
}

class CurrentLocationRequested extends CurrentLocationEvent {
  @override
  List<Object> get props => [];
}
