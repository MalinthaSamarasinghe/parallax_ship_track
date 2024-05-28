part of 'current_location_bloc.dart';

enum CurrentLocationStatus { initial, loading, success, failure }

class CurrentLocationState extends Equatable {
  final CurrentLocationStatus status;
  final Position? currentLocationData;
  final String? failureMessage;

  const CurrentLocationState({
    this.status = CurrentLocationStatus.initial,
    this.currentLocationData,
    this.failureMessage,
  });

  @override
  List<Object?> get props => [
        status,
        currentLocationData,
        failureMessage,
      ];

  CurrentLocationState copyWith({
    CurrentLocationStatus? status,
    String? failureMessage,
    Position? currentLocationData,
  }) {
    return CurrentLocationState(
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
      currentLocationData: currentLocationData ?? this.currentLocationData,
    );
  }
}
