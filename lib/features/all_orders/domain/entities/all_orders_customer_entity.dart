import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'all_orders_customer_entity.g.dart';

@CopyWith()
class AllOrdersCustomerEntity extends Equatable {
  final String customerAddress;
  final String customerCity;
  final String customerImage;
  final String customerMail;
  final String customerName;
  final String customerNumber;
  final String customerWearHouse;

  const AllOrdersCustomerEntity({
    required this.customerAddress,
    required this.customerCity,
    required this.customerImage,
    required this.customerMail,
    required this.customerName,
    required this.customerNumber,
    required this.customerWearHouse,
  });

  @override
  List<Object> get props => [
        customerAddress,
        customerCity,
        customerImage,
        customerMail,
        customerName,
        customerNumber,
        customerWearHouse,
      ];
}
