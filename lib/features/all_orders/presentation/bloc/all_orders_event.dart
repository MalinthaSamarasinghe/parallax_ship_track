part of 'all_orders_bloc.dart';

abstract class AllOrdersEvent extends Equatable {
  const AllOrdersEvent();
}

class AllOrdersChanged extends AllOrdersEvent {
  final firebase_database.DatabaseEvent? data;

  const AllOrdersChanged(this.data);

  @override
  List<Object?> get props => [data];
}
