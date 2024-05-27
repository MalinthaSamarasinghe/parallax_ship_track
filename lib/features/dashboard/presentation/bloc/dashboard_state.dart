part of 'dashboard_bloc.dart';

enum DashboardStatus { initial, loading, success, failure }

class DashboardState extends Equatable {
  final DashboardStatus status;
  final List<DashboardParams>? data;
  final String? successMessage;
  final String? errorMessage;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.data,
    this.successMessage,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, data, successMessage, errorMessage];

  DashboardState copyWith({
    DashboardStatus? status,
    List<DashboardParams>? data,
    String? successMessage,
    String? errorMessage,
  }) {
    return DashboardState(
      status: status ?? this.status,
      data: data ?? this.data,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class DashboardParams extends Equatable {
  final String uid;
  final String staticCategory;
  final String staticType;
  final String value;

  const DashboardParams({
    required this.uid,
    required this.staticCategory,
    required this.staticType,
    required this.value,
  });

  @override
  List<Object> get props => [uid, staticCategory, staticType, value];
}
