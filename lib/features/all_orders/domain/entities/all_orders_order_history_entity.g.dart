// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_orders_order_history_entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AllOrdersOrderHistoryEntityCWProxy {
  AllOrdersOrderHistoryEntity orderHistoryMessage(String orderHistoryMessage);

  AllOrdersOrderHistoryEntity orderHistoryType(String orderHistoryType);

  AllOrdersOrderHistoryEntity orderHistoryUserOne(String orderHistoryUserOne);

  AllOrdersOrderHistoryEntity orderHistoryUserTwo(String orderHistoryUserTwo);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllOrdersOrderHistoryEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllOrdersOrderHistoryEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  AllOrdersOrderHistoryEntity call({
    String? orderHistoryMessage,
    String? orderHistoryType,
    String? orderHistoryUserOne,
    String? orderHistoryUserTwo,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAllOrdersOrderHistoryEntity.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAllOrdersOrderHistoryEntity.copyWith.fieldName(...)`
class _$AllOrdersOrderHistoryEntityCWProxyImpl
    implements _$AllOrdersOrderHistoryEntityCWProxy {
  const _$AllOrdersOrderHistoryEntityCWProxyImpl(this._value);

  final AllOrdersOrderHistoryEntity _value;

  @override
  AllOrdersOrderHistoryEntity orderHistoryMessage(String orderHistoryMessage) =>
      this(orderHistoryMessage: orderHistoryMessage);

  @override
  AllOrdersOrderHistoryEntity orderHistoryType(String orderHistoryType) =>
      this(orderHistoryType: orderHistoryType);

  @override
  AllOrdersOrderHistoryEntity orderHistoryUserOne(String orderHistoryUserOne) =>
      this(orderHistoryUserOne: orderHistoryUserOne);

  @override
  AllOrdersOrderHistoryEntity orderHistoryUserTwo(String orderHistoryUserTwo) =>
      this(orderHistoryUserTwo: orderHistoryUserTwo);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllOrdersOrderHistoryEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllOrdersOrderHistoryEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  AllOrdersOrderHistoryEntity call({
    Object? orderHistoryMessage = const $CopyWithPlaceholder(),
    Object? orderHistoryType = const $CopyWithPlaceholder(),
    Object? orderHistoryUserOne = const $CopyWithPlaceholder(),
    Object? orderHistoryUserTwo = const $CopyWithPlaceholder(),
  }) {
    return AllOrdersOrderHistoryEntity(
      orderHistoryMessage:
          orderHistoryMessage == const $CopyWithPlaceholder() ||
                  orderHistoryMessage == null
              ? _value.orderHistoryMessage
              // ignore: cast_nullable_to_non_nullable
              : orderHistoryMessage as String,
      orderHistoryType: orderHistoryType == const $CopyWithPlaceholder() ||
              orderHistoryType == null
          ? _value.orderHistoryType
          // ignore: cast_nullable_to_non_nullable
          : orderHistoryType as String,
      orderHistoryUserOne:
          orderHistoryUserOne == const $CopyWithPlaceholder() ||
                  orderHistoryUserOne == null
              ? _value.orderHistoryUserOne
              // ignore: cast_nullable_to_non_nullable
              : orderHistoryUserOne as String,
      orderHistoryUserTwo:
          orderHistoryUserTwo == const $CopyWithPlaceholder() ||
                  orderHistoryUserTwo == null
              ? _value.orderHistoryUserTwo
              // ignore: cast_nullable_to_non_nullable
              : orderHistoryUserTwo as String,
    );
  }
}

extension $AllOrdersOrderHistoryEntityCopyWith on AllOrdersOrderHistoryEntity {
  /// Returns a callable class that can be used as follows: `instanceOfAllOrdersOrderHistoryEntity.copyWith(...)` or like so:`instanceOfAllOrdersOrderHistoryEntity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AllOrdersOrderHistoryEntityCWProxy get copyWith =>
      _$AllOrdersOrderHistoryEntityCWProxyImpl(this);
}
