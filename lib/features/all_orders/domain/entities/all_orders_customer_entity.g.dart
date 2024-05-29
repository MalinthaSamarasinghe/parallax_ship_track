// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_orders_customer_entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AllOrdersCustomerEntityCWProxy {
  AllOrdersCustomerEntity customerAddress(String customerAddress);

  AllOrdersCustomerEntity customerCity(String customerCity);

  AllOrdersCustomerEntity customerImage(String customerImage);

  AllOrdersCustomerEntity customerMail(String customerMail);

  AllOrdersCustomerEntity customerName(String customerName);

  AllOrdersCustomerEntity customerNumber(String customerNumber);

  AllOrdersCustomerEntity customerWearHouse(String customerWearHouse);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllOrdersCustomerEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllOrdersCustomerEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  AllOrdersCustomerEntity call({
    String? customerAddress,
    String? customerCity,
    String? customerImage,
    String? customerMail,
    String? customerName,
    String? customerNumber,
    String? customerWearHouse,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAllOrdersCustomerEntity.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAllOrdersCustomerEntity.copyWith.fieldName(...)`
class _$AllOrdersCustomerEntityCWProxyImpl
    implements _$AllOrdersCustomerEntityCWProxy {
  const _$AllOrdersCustomerEntityCWProxyImpl(this._value);

  final AllOrdersCustomerEntity _value;

  @override
  AllOrdersCustomerEntity customerAddress(String customerAddress) =>
      this(customerAddress: customerAddress);

  @override
  AllOrdersCustomerEntity customerCity(String customerCity) =>
      this(customerCity: customerCity);

  @override
  AllOrdersCustomerEntity customerImage(String customerImage) =>
      this(customerImage: customerImage);

  @override
  AllOrdersCustomerEntity customerMail(String customerMail) =>
      this(customerMail: customerMail);

  @override
  AllOrdersCustomerEntity customerName(String customerName) =>
      this(customerName: customerName);

  @override
  AllOrdersCustomerEntity customerNumber(String customerNumber) =>
      this(customerNumber: customerNumber);

  @override
  AllOrdersCustomerEntity customerWearHouse(String customerWearHouse) =>
      this(customerWearHouse: customerWearHouse);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllOrdersCustomerEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllOrdersCustomerEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  AllOrdersCustomerEntity call({
    Object? customerAddress = const $CopyWithPlaceholder(),
    Object? customerCity = const $CopyWithPlaceholder(),
    Object? customerImage = const $CopyWithPlaceholder(),
    Object? customerMail = const $CopyWithPlaceholder(),
    Object? customerName = const $CopyWithPlaceholder(),
    Object? customerNumber = const $CopyWithPlaceholder(),
    Object? customerWearHouse = const $CopyWithPlaceholder(),
  }) {
    return AllOrdersCustomerEntity(
      customerAddress: customerAddress == const $CopyWithPlaceholder() ||
              customerAddress == null
          ? _value.customerAddress
          // ignore: cast_nullable_to_non_nullable
          : customerAddress as String,
      customerCity:
          customerCity == const $CopyWithPlaceholder() || customerCity == null
              ? _value.customerCity
              // ignore: cast_nullable_to_non_nullable
              : customerCity as String,
      customerImage:
          customerImage == const $CopyWithPlaceholder() || customerImage == null
              ? _value.customerImage
              // ignore: cast_nullable_to_non_nullable
              : customerImage as String,
      customerMail:
          customerMail == const $CopyWithPlaceholder() || customerMail == null
              ? _value.customerMail
              // ignore: cast_nullable_to_non_nullable
              : customerMail as String,
      customerName:
          customerName == const $CopyWithPlaceholder() || customerName == null
              ? _value.customerName
              // ignore: cast_nullable_to_non_nullable
              : customerName as String,
      customerNumber: customerNumber == const $CopyWithPlaceholder() ||
              customerNumber == null
          ? _value.customerNumber
          // ignore: cast_nullable_to_non_nullable
          : customerNumber as String,
      customerWearHouse: customerWearHouse == const $CopyWithPlaceholder() ||
              customerWearHouse == null
          ? _value.customerWearHouse
          // ignore: cast_nullable_to_non_nullable
          : customerWearHouse as String,
    );
  }
}

extension $AllOrdersCustomerEntityCopyWith on AllOrdersCustomerEntity {
  /// Returns a callable class that can be used as follows: `instanceOfAllOrdersCustomerEntity.copyWith(...)` or like so:`instanceOfAllOrdersCustomerEntity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AllOrdersCustomerEntityCWProxy get copyWith =>
      _$AllOrdersCustomerEntityCWProxyImpl(this);
}
