// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_statistics_entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DashboardStatisticsEntityCWProxy {
  DashboardStatisticsEntity name(String name);

  DashboardStatisticsEntity value(String value);

  DashboardStatisticsEntity mainCategory(String mainCategory);

  DashboardStatisticsEntity imagePath(String imagePath);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DashboardStatisticsEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DashboardStatisticsEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  DashboardStatisticsEntity call({
    String? name,
    String? value,
    String? mainCategory,
    String? imagePath,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDashboardStatisticsEntity.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDashboardStatisticsEntity.copyWith.fieldName(...)`
class _$DashboardStatisticsEntityCWProxyImpl
    implements _$DashboardStatisticsEntityCWProxy {
  const _$DashboardStatisticsEntityCWProxyImpl(this._value);

  final DashboardStatisticsEntity _value;

  @override
  DashboardStatisticsEntity name(String name) => this(name: name);

  @override
  DashboardStatisticsEntity value(String value) => this(value: value);

  @override
  DashboardStatisticsEntity mainCategory(String mainCategory) =>
      this(mainCategory: mainCategory);

  @override
  DashboardStatisticsEntity imagePath(String imagePath) =>
      this(imagePath: imagePath);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DashboardStatisticsEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DashboardStatisticsEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  DashboardStatisticsEntity call({
    Object? name = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? mainCategory = const $CopyWithPlaceholder(),
    Object? imagePath = const $CopyWithPlaceholder(),
  }) {
    return DashboardStatisticsEntity(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      value: value == const $CopyWithPlaceholder() || value == null
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as String,
      mainCategory:
          mainCategory == const $CopyWithPlaceholder() || mainCategory == null
              ? _value.mainCategory
              // ignore: cast_nullable_to_non_nullable
              : mainCategory as String,
      imagePath: imagePath == const $CopyWithPlaceholder() || imagePath == null
          ? _value.imagePath
          // ignore: cast_nullable_to_non_nullable
          : imagePath as String,
    );
  }
}

extension $DashboardStatisticsEntityCopyWith on DashboardStatisticsEntity {
  /// Returns a callable class that can be used as follows: `instanceOfDashboardStatisticsEntity.copyWith(...)` or like so:`instanceOfDashboardStatisticsEntity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DashboardStatisticsEntityCWProxy get copyWith =>
      _$DashboardStatisticsEntityCWProxyImpl(this);
}
