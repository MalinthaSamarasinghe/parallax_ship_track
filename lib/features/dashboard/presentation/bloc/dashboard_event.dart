part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class DashboardDataChanged extends DashboardEvent {
  final firebase_database.DatabaseEvent? data;

  const DashboardDataChanged(this.data);

  @override
  List<Object?> get props => [data];
}
