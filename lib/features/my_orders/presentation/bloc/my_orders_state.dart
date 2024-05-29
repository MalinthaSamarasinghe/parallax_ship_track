part of 'my_orders_bloc.dart';

enum MyOrdersStatus { initial, loading, success, failure }

class MyOrdersState extends Equatable {
  final MyOrdersStatus status;
  final List<DashboardStatisticsEntity>? myOrdersData;
  final String? successMessage;
  final String? errorMessage;

  const MyOrdersState({
    this.status = MyOrdersStatus.initial,
    this.myOrdersData = const [],
    this.successMessage,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, myOrdersData, successMessage, errorMessage];

  MyOrdersState copyWith({
    MyOrdersStatus? status,
    List<DashboardStatisticsEntity>? myOrdersData,
    String? successMessage,
    String? errorMessage,
  }) {
    return MyOrdersState(
      status: status ?? this.status,
      myOrdersData: myOrdersData ?? this.myOrdersData,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
