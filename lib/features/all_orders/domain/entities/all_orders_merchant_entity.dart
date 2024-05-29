import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'all_orders_merchant_entity.g.dart';

@CopyWith()
class AllOrdersMerchantEntity extends Equatable {
  final String merchantAddress;
  final String merchantCity;
  final String merchantId;
  final String merchantImage;
  final String merchantName;
  final String merchantWearHouse;

  const AllOrdersMerchantEntity({
    required this.merchantAddress,
    required this.merchantCity,
    required this.merchantId,
    required this.merchantImage,
    required this.merchantName,
    required this.merchantWearHouse,
  });

  @override
  List<Object> get props => [
        merchantAddress,
        merchantCity,
        merchantId,
        merchantImage,
        merchantName,
        merchantWearHouse,
      ];
}
