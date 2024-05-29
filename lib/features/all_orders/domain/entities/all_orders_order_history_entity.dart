import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'all_orders_order_history_entity.g.dart';

@CopyWith()
class AllOrdersOrderHistoryEntity extends Equatable {
  final String orderHistoryMessage;
  final String orderHistoryType;
  final String orderHistoryUserOne;
  final String orderHistoryUserTwo;

  const AllOrdersOrderHistoryEntity({
    required this.orderHistoryMessage,
    required this.orderHistoryType,
    required this.orderHistoryUserOne,
    required this.orderHistoryUserTwo,
  });

  @override
  List<Object> get props => [
        orderHistoryMessage,
        orderHistoryType,
        orderHistoryUserOne,
        orderHistoryUserTwo,
      ];
}
