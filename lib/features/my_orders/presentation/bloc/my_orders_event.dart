part of 'my_orders_bloc.dart';

abstract class MyOrdersEvent extends Equatable {
  const MyOrdersEvent();
}

class MyOrdersChanged extends MyOrdersEvent {
  final firebase_database.DatabaseEvent? data;

  const MyOrdersChanged(this.data);

  @override
  List<Object?> get props => [data];
}
