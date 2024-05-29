// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_orders_invoice_history_entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AllOrdersInvoiceHistoryEntityCWProxy {
  AllOrdersInvoiceHistoryEntity invoiceHistoryAmount(
      String invoiceHistoryAmount);

  AllOrdersInvoiceHistoryEntity invoiceHistoryType(String invoiceHistoryType);

  AllOrdersInvoiceHistoryEntity invoiceHistoryUserOne(
      String invoiceHistoryUserOne);

  AllOrdersInvoiceHistoryEntity invoiceHistoryUserTwo(
      String invoiceHistoryUserTwo);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllOrdersInvoiceHistoryEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllOrdersInvoiceHistoryEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  AllOrdersInvoiceHistoryEntity call({
    String? invoiceHistoryAmount,
    String? invoiceHistoryType,
    String? invoiceHistoryUserOne,
    String? invoiceHistoryUserTwo,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAllOrdersInvoiceHistoryEntity.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAllOrdersInvoiceHistoryEntity.copyWith.fieldName(...)`
class _$AllOrdersInvoiceHistoryEntityCWProxyImpl
    implements _$AllOrdersInvoiceHistoryEntityCWProxy {
  const _$AllOrdersInvoiceHistoryEntityCWProxyImpl(this._value);

  final AllOrdersInvoiceHistoryEntity _value;

  @override
  AllOrdersInvoiceHistoryEntity invoiceHistoryAmount(
          String invoiceHistoryAmount) =>
      this(invoiceHistoryAmount: invoiceHistoryAmount);

  @override
  AllOrdersInvoiceHistoryEntity invoiceHistoryType(String invoiceHistoryType) =>
      this(invoiceHistoryType: invoiceHistoryType);

  @override
  AllOrdersInvoiceHistoryEntity invoiceHistoryUserOne(
          String invoiceHistoryUserOne) =>
      this(invoiceHistoryUserOne: invoiceHistoryUserOne);

  @override
  AllOrdersInvoiceHistoryEntity invoiceHistoryUserTwo(
          String invoiceHistoryUserTwo) =>
      this(invoiceHistoryUserTwo: invoiceHistoryUserTwo);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllOrdersInvoiceHistoryEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllOrdersInvoiceHistoryEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  AllOrdersInvoiceHistoryEntity call({
    Object? invoiceHistoryAmount = const $CopyWithPlaceholder(),
    Object? invoiceHistoryType = const $CopyWithPlaceholder(),
    Object? invoiceHistoryUserOne = const $CopyWithPlaceholder(),
    Object? invoiceHistoryUserTwo = const $CopyWithPlaceholder(),
  }) {
    return AllOrdersInvoiceHistoryEntity(
      invoiceHistoryAmount:
          invoiceHistoryAmount == const $CopyWithPlaceholder() ||
                  invoiceHistoryAmount == null
              ? _value.invoiceHistoryAmount
              // ignore: cast_nullable_to_non_nullable
              : invoiceHistoryAmount as String,
      invoiceHistoryType: invoiceHistoryType == const $CopyWithPlaceholder() ||
              invoiceHistoryType == null
          ? _value.invoiceHistoryType
          // ignore: cast_nullable_to_non_nullable
          : invoiceHistoryType as String,
      invoiceHistoryUserOne:
          invoiceHistoryUserOne == const $CopyWithPlaceholder() ||
                  invoiceHistoryUserOne == null
              ? _value.invoiceHistoryUserOne
              // ignore: cast_nullable_to_non_nullable
              : invoiceHistoryUserOne as String,
      invoiceHistoryUserTwo:
          invoiceHistoryUserTwo == const $CopyWithPlaceholder() ||
                  invoiceHistoryUserTwo == null
              ? _value.invoiceHistoryUserTwo
              // ignore: cast_nullable_to_non_nullable
              : invoiceHistoryUserTwo as String,
    );
  }
}

extension $AllOrdersInvoiceHistoryEntityCopyWith
    on AllOrdersInvoiceHistoryEntity {
  /// Returns a callable class that can be used as follows: `instanceOfAllOrdersInvoiceHistoryEntity.copyWith(...)` or like so:`instanceOfAllOrdersInvoiceHistoryEntity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AllOrdersInvoiceHistoryEntityCWProxy get copyWith =>
      _$AllOrdersInvoiceHistoryEntityCWProxyImpl(this);
}
