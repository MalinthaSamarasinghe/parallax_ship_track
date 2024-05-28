part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class DashboardOrderStatisticsChanged extends DashboardEvent {
  final firebase_database.DatabaseEvent? data;

  const DashboardOrderStatisticsChanged(this.data);

  @override
  List<Object?> get props => [data];
}

class DashboardFinanceStatisticsChanged extends DashboardEvent {
  final firebase_database.DatabaseEvent? data;

  const DashboardFinanceStatisticsChanged(this.data);

  @override
  List<Object?> get props => [data];
}
