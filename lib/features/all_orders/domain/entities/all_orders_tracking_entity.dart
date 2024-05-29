import 'all_orders_remark_entity.dart';
import 'all_orders_merchant_entity.dart';
import 'all_orders_customer_entity.dart';
import 'package:equatable/equatable.dart';
import 'all_orders_invoice_history_entity.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'all_orders_tracking_entity.g.dart';

@CopyWith()
class AllOrdersTrackingEntity extends Equatable {
  final double latitude;
  final double longitude;

  const AllOrdersTrackingEntity({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [
        latitude,
        longitude,
      ];
}
