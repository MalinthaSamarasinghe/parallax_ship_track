import 'all_orders_remark_entity.dart';
import 'all_orders_tracking_entity.dart';
import 'all_orders_merchant_entity.dart';
import 'all_orders_customer_entity.dart';
import 'package:equatable/equatable.dart';
import 'all_orders_order_history_entity.dart';
import 'all_orders_invoice_history_entity.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'all_orders_entity.g.dart';

@CopyWith()
class AllOrdersEntity extends Equatable {
  final String cod;
  final String code;
  final String createdOn;
  final String status;
  final String updatedAt;
  final String weight;
  final AllOrdersCustomerEntity allOrdersCustomerData;
  final List<AllOrdersRemarkEntity> allOrdersRemarkData;
  final List<AllOrdersInvoiceHistoryEntity> allOrdersInvoiceHistoryData;
  final AllOrdersMerchantEntity allOrdersMerchantData;
  final List<AllOrdersOrderHistoryEntity> allOrdersOrderHistoryData;
  final AllOrdersTrackingEntity allOrdersTrackingData;

  const AllOrdersEntity({
    required this.cod,
    required this.code,
    required this.createdOn,
    required this.status,
    required this.updatedAt,
    required this.weight,
    required this.allOrdersCustomerData,
    required this.allOrdersRemarkData,
    required this.allOrdersInvoiceHistoryData,
    required this.allOrdersMerchantData,
    required this.allOrdersOrderHistoryData,
    required this.allOrdersTrackingData,
  });

  @override
  List<Object> get props => [
        cod,
        code,
        createdOn,
        status,
        updatedAt,
        weight,
        allOrdersCustomerData,
        allOrdersRemarkData,
        allOrdersInvoiceHistoryData,
        allOrdersMerchantData,
        allOrdersOrderHistoryData,
        allOrdersTrackingData,
      ];
}
