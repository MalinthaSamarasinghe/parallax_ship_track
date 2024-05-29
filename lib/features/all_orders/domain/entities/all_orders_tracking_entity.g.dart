// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_orders_tracking_entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AllOrdersTrackingEntityCWProxy {
  AllOrdersTrackingEntity latitude(double latitude);

  AllOrdersTrackingEntity longitude(double longitude);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllOrdersTrackingEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllOrdersTrackingEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  AllOrdersTrackingEntity call({
    double? latitude,
    double? longitude,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAllOrdersTrackingEntity.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAllOrdersTrackingEntity.copyWith.fieldName(...)`
class _$AllOrdersTrackingEntityCWProxyImpl
    implements _$AllOrdersTrackingEntityCWProxy {
  const _$AllOrdersTrackingEntityCWProxyImpl(this._value);

  final AllOrdersTrackingEntity _value;

  @override
  AllOrdersTrackingEntity latitude(double latitude) => this(latitude: latitude);

  @override
  AllOrdersTrackingEntity longitude(double longitude) =>
      this(longitude: longitude);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllOrdersTrackingEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllOrdersTrackingEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  AllOrdersTrackingEntity call({
    Object? latitude = const $CopyWithPlaceholder(),
    Object? longitude = const $CopyWithPlaceholder(),
  }) {
    return AllOrdersTrackingEntity(
      latitude: latitude == const $CopyWithPlaceholder() || latitude == null
          ? _value.latitude
          // ignore: cast_nullable_to_non_nullable
          : latitude as double,
      longitude: longitude == const $CopyWithPlaceholder() || longitude == null
          ? _value.longitude
          // ignore: cast_nullable_to_non_nullable
          : longitude as double,
    );
  }
}

extension $AllOrdersTrackingEntityCopyWith on AllOrdersTrackingEntity {
  /// Returns a callable class that can be used as follows: `instanceOfAllOrdersTrackingEntity.copyWith(...)` or like so:`instanceOfAllOrdersTrackingEntity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AllOrdersTrackingEntityCWProxy get copyWith =>
      _$AllOrdersTrackingEntityCWProxyImpl(this);
}
