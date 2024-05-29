// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_orders_entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AllOrdersEntityCWProxy {
  AllOrdersEntity cod(String cod);

  AllOrdersEntity code(String code);

  AllOrdersEntity createdOn(String createdOn);

  AllOrdersEntity status(String status);

  AllOrdersEntity updatedAt(String updatedAt);

  AllOrdersEntity weight(String weight);

  AllOrdersEntity allOrdersCustomerData(
      AllOrdersCustomerEntity allOrdersCustomerData);

  AllOrdersEntity allOrdersRemarkData(
      List<AllOrdersRemarkEntity> allOrdersRemarkData);

  AllOrdersEntity allOrdersInvoiceHistoryData(
      List<AllOrdersInvoiceHistoryEntity> allOrdersInvoiceHistoryData);

  AllOrdersEntity allOrdersMerchantData(
      AllOrdersMerchantEntity allOrdersMerchantData);

  AllOrdersEntity allOrdersOrderHistoryData(
      List<AllOrdersOrderHistoryEntity> allOrdersOrderHistoryData);

  AllOrdersEntity allOrdersTrackingData(
      AllOrdersTrackingEntity allOrdersTrackingData);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllOrdersEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllOrdersEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  AllOrdersEntity call({
    String? cod,
    String? code,
    String? createdOn,
    String? status,
    String? updatedAt,
    String? weight,
    AllOrdersCustomerEntity? allOrdersCustomerData,
    List<AllOrdersRemarkEntity>? allOrdersRemarkData,
    List<AllOrdersInvoiceHistoryEntity>? allOrdersInvoiceHistoryData,
    AllOrdersMerchantEntity? allOrdersMerchantData,
    List<AllOrdersOrderHistoryEntity>? allOrdersOrderHistoryData,
    AllOrdersTrackingEntity? allOrdersTrackingData,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAllOrdersEntity.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAllOrdersEntity.copyWith.fieldName(...)`
class _$AllOrdersEntityCWProxyImpl implements _$AllOrdersEntityCWProxy {
  const _$AllOrdersEntityCWProxyImpl(this._value);

  final AllOrdersEntity _value;

  @override
  AllOrdersEntity cod(String cod) => this(cod: cod);

  @override
  AllOrdersEntity code(String code) => this(code: code);

  @override
  AllOrdersEntity createdOn(String createdOn) => this(createdOn: createdOn);

  @override
  AllOrdersEntity status(String status) => this(status: status);

  @override
  AllOrdersEntity updatedAt(String updatedAt) => this(updatedAt: updatedAt);

  @override
  AllOrdersEntity weight(String weight) => this(weight: weight);

  @override
  AllOrdersEntity allOrdersCustomerData(
          AllOrdersCustomerEntity allOrdersCustomerData) =>
      this(allOrdersCustomerData: allOrdersCustomerData);

  @override
  AllOrdersEntity allOrdersRemarkData(
          List<AllOrdersRemarkEntity> allOrdersRemarkData) =>
      this(allOrdersRemarkData: allOrdersRemarkData);

  @override
  AllOrdersEntity allOrdersInvoiceHistoryData(
          List<AllOrdersInvoiceHistoryEntity> allOrdersInvoiceHistoryData) =>
      this(allOrdersInvoiceHistoryData: allOrdersInvoiceHistoryData);

  @override
  AllOrdersEntity allOrdersMerchantData(
          AllOrdersMerchantEntity allOrdersMerchantData) =>
      this(allOrdersMerchantData: allOrdersMerchantData);

  @override
  AllOrdersEntity allOrdersOrderHistoryData(
          List<AllOrdersOrderHistoryEntity> allOrdersOrderHistoryData) =>
      this(allOrdersOrderHistoryData: allOrdersOrderHistoryData);

  @override
  AllOrdersEntity allOrdersTrackingData(
          AllOrdersTrackingEntity allOrdersTrackingData) =>
      this(allOrdersTrackingData: allOrdersTrackingData);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllOrdersEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllOrdersEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  AllOrdersEntity call({
    Object? cod = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? createdOn = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? weight = const $CopyWithPlaceholder(),
    Object? allOrdersCustomerData = const $CopyWithPlaceholder(),
    Object? allOrdersRemarkData = const $CopyWithPlaceholder(),
    Object? allOrdersInvoiceHistoryData = const $CopyWithPlaceholder(),
    Object? allOrdersMerchantData = const $CopyWithPlaceholder(),
    Object? allOrdersOrderHistoryData = const $CopyWithPlaceholder(),
    Object? allOrdersTrackingData = const $CopyWithPlaceholder(),
  }) {
    return AllOrdersEntity(
      cod: cod == const $CopyWithPlaceholder() || cod == null
          ? _value.cod
          // ignore: cast_nullable_to_non_nullable
          : cod as String,
      code: code == const $CopyWithPlaceholder() || code == null
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      createdOn: createdOn == const $CopyWithPlaceholder() || createdOn == null
          ? _value.createdOn
          // ignore: cast_nullable_to_non_nullable
          : createdOn as String,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as String,
      weight: weight == const $CopyWithPlaceholder() || weight == null
          ? _value.weight
          // ignore: cast_nullable_to_non_nullable
          : weight as String,
      allOrdersCustomerData:
          allOrdersCustomerData == const $CopyWithPlaceholder() ||
                  allOrdersCustomerData == null
              ? _value.allOrdersCustomerData
              // ignore: cast_nullable_to_non_nullable
              : allOrdersCustomerData as AllOrdersCustomerEntity,
      allOrdersRemarkData:
          allOrdersRemarkData == const $CopyWithPlaceholder() ||
                  allOrdersRemarkData == null
              ? _value.allOrdersRemarkData
              // ignore: cast_nullable_to_non_nullable
              : allOrdersRemarkData as List<AllOrdersRemarkEntity>,
      allOrdersInvoiceHistoryData: allOrdersInvoiceHistoryData ==
                  const $CopyWithPlaceholder() ||
              allOrdersInvoiceHistoryData == null
          ? _value.allOrdersInvoiceHistoryData
          // ignore: cast_nullable_to_non_nullable
          : allOrdersInvoiceHistoryData as List<AllOrdersInvoiceHistoryEntity>,
      allOrdersMerchantData:
          allOrdersMerchantData == const $CopyWithPlaceholder() ||
                  allOrdersMerchantData == null
              ? _value.allOrdersMerchantData
              // ignore: cast_nullable_to_non_nullable
              : allOrdersMerchantData as AllOrdersMerchantEntity,
      allOrdersOrderHistoryData:
          allOrdersOrderHistoryData == const $CopyWithPlaceholder() ||
                  allOrdersOrderHistoryData == null
              ? _value.allOrdersOrderHistoryData
              // ignore: cast_nullable_to_non_nullable
              : allOrdersOrderHistoryData as List<AllOrdersOrderHistoryEntity>,
      allOrdersTrackingData:
          allOrdersTrackingData == const $CopyWithPlaceholder() ||
                  allOrdersTrackingData == null
              ? _value.allOrdersTrackingData
              // ignore: cast_nullable_to_non_nullable
              : allOrdersTrackingData as AllOrdersTrackingEntity,
    );
  }
}

extension $AllOrdersEntityCopyWith on AllOrdersEntity {
  /// Returns a callable class that can be used as follows: `instanceOfAllOrdersEntity.copyWith(...)` or like so:`instanceOfAllOrdersEntity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AllOrdersEntityCWProxy get copyWith => _$AllOrdersEntityCWProxyImpl(this);
}
