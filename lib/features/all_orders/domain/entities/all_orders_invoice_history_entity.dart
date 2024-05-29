import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'all_orders_invoice_history_entity.g.dart';

@CopyWith()
class AllOrdersInvoiceHistoryEntity extends Equatable {
  final String invoiceHistoryAmount;
  final String invoiceHistoryType;
  final String invoiceHistoryUserOne;
  final String invoiceHistoryUserTwo;

  const AllOrdersInvoiceHistoryEntity({
    required this.invoiceHistoryAmount,
    required this.invoiceHistoryType,
    required this.invoiceHistoryUserOne,
    required this.invoiceHistoryUserTwo,
  });

  @override
  List<Object> get props => [
        invoiceHistoryAmount,
        invoiceHistoryType,
        invoiceHistoryUserOne,
        invoiceHistoryUserTwo,
      ];
}
