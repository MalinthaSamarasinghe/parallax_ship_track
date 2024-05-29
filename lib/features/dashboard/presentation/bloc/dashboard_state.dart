part of 'dashboard_bloc.dart';

enum DashboardStatus { initial, loading, success, failure }

class DashboardState extends Equatable {
  final DashboardStatus status;
  final List<DashboardStatisticsEntity>? dashboardOrderStatisticsData;
  final List<DashboardStatisticsEntity>? dashboardFinanceStatisticsData;
  final String? successMessage;
  final String? errorMessage;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.dashboardOrderStatisticsData = const [],
    this.dashboardFinanceStatisticsData = const [],
    this.successMessage,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, dashboardOrderStatisticsData, dashboardFinanceStatisticsData, successMessage, errorMessage];

  DashboardState copyWith({
    DashboardStatus? status,
    List<DashboardStatisticsEntity>? dashboardOrderStatisticsData,
    List<DashboardStatisticsEntity>? dashboardFinanceStatisticsData,
    String? successMessage,
    String? errorMessage,
  }) {
    return DashboardState(
      status: status ?? this.status,
      dashboardOrderStatisticsData: dashboardOrderStatisticsData ?? this.dashboardOrderStatisticsData,
      dashboardFinanceStatisticsData: dashboardFinanceStatisticsData ?? this.dashboardFinanceStatisticsData,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
