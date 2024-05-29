// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_orders_merchant_entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AllOrdersMerchantEntityCWProxy {
  AllOrdersMerchantEntity merchantAddress(String merchantAddress);

  AllOrdersMerchantEntity merchantCity(String merchantCity);

  AllOrdersMerchantEntity merchantId(String merchantId);

  AllOrdersMerchantEntity merchantImage(String merchantImage);

  AllOrdersMerchantEntity merchantName(String merchantName);

  AllOrdersMerchantEntity merchantWearHouse(String merchantWearHouse);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllOrdersMerchantEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllOrdersMerchantEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  AllOrdersMerchantEntity call({
    String? merchantAddress,
    String? merchantCity,
    String? merchantId,
    String? merchantImage,
    String? merchantName,
    String? merchantWearHouse,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAllOrdersMerchantEntity.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAllOrdersMerchantEntity.copyWith.fieldName(...)`
class _$AllOrdersMerchantEntityCWProxyImpl
    implements _$AllOrdersMerchantEntityCWProxy {
  const _$AllOrdersMerchantEntityCWProxyImpl(this._value);

  final AllOrdersMerchantEntity _value;

  @override
  AllOrdersMerchantEntity merchantAddress(String merchantAddress) =>
      this(merchantAddress: merchantAddress);

  @override
  AllOrdersMerchantEntity merchantCity(String merchantCity) =>
      this(merchantCity: merchantCity);

  @override
  AllOrdersMerchantEntity merchantId(String merchantId) =>
      this(merchantId: merchantId);

  @override
  AllOrdersMerchantEntity merchantImage(String merchantImage) =>
      this(merchantImage: merchantImage);

  @override
  AllOrdersMerchantEntity merchantName(String merchantName) =>
      this(merchantName: merchantName);

  @override
  AllOrdersMerchantEntity merchantWearHouse(String merchantWearHouse) =>
      this(merchantWearHouse: merchantWearHouse);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllOrdersMerchantEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllOrdersMerchantEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  AllOrdersMerchantEntity call({
    Object? merchantAddress = const $CopyWithPlaceholder(),
    Object? merchantCity = const $CopyWithPlaceholder(),
    Object? merchantId = const $CopyWithPlaceholder(),
    Object? merchantImage = const $CopyWithPlaceholder(),
    Object? merchantName = const $CopyWithPlaceholder(),
    Object? merchantWearHouse = const $CopyWithPlaceholder(),
  }) {
    return AllOrdersMerchantEntity(
      merchantAddress: merchantAddress == const $CopyWithPlaceholder() ||
              merchantAddress == null
          ? _value.merchantAddress
          // ignore: cast_nullable_to_non_nullable
          : merchantAddress as String,
      merchantCity:
          merchantCity == const $CopyWithPlaceholder() || merchantCity == null
              ? _value.merchantCity
              // ignore: cast_nullable_to_non_nullable
              : merchantCity as String,
      merchantId:
          merchantId == const $CopyWithPlaceholder() || merchantId == null
              ? _value.merchantId
              // ignore: cast_nullable_to_non_nullable
              : merchantId as String,
      merchantImage:
          merchantImage == const $CopyWithPlaceholder() || merchantImage == null
              ? _value.merchantImage
              // ignore: cast_nullable_to_non_nullable
              : merchantImage as String,
      merchantName:
          merchantName == const $CopyWithPlaceholder() || merchantName == null
              ? _value.merchantName
              // ignore: cast_nullable_to_non_nullable
              : merchantName as String,
      merchantWearHouse: merchantWearHouse == const $CopyWithPlaceholder() ||
              merchantWearHouse == null
          ? _value.merchantWearHouse
          // ignore: cast_nullable_to_non_nullable
          : merchantWearHouse as String,
    );
  }
}

extension $AllOrdersMerchantEntityCopyWith on AllOrdersMerchantEntity {
  /// Returns a callable class that can be used as follows: `instanceOfAllOrdersMerchantEntity.copyWith(...)` or like so:`instanceOfAllOrdersMerchantEntity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AllOrdersMerchantEntityCWProxy get copyWith =>
      _$AllOrdersMerchantEntityCWProxyImpl(this);
}
