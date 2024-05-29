part of 'all_orders_bloc.dart';

enum AllOrdersStatus { initial, loading, success, failure }

class AllOrdersState extends Equatable {
  final AllOrdersStatus status;
  final List<AllOrdersEntity>? allOrdersData;
  final String? successMessage;
  final String? errorMessage;

  const AllOrdersState({
    this.status = AllOrdersStatus.initial,
    this.allOrdersData = const [],
    this.successMessage,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, allOrdersData, successMessage, errorMessage];

  AllOrdersState copyWith({
    AllOrdersStatus? status,
    List<AllOrdersEntity>? allOrdersData,
    String? successMessage,
    String? errorMessage,
  }) {
    return AllOrdersState(
      status: status ?? this.status,
      allOrdersData: allOrdersData ?? this.allOrdersData,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
