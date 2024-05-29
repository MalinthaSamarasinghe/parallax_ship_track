// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_orders_remark_entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AllOrdersRemarkEntityCWProxy {
  AllOrdersRemarkEntity readBy(String readBy);

  AllOrdersRemarkEntity remark(String remark);

  AllOrdersRemarkEntity remarkDate(String remarkDate);

  AllOrdersRemarkEntity remarkedBy(String remarkedBy);

  AllOrdersRemarkEntity tag(String tag);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllOrdersRemarkEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllOrdersRemarkEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  AllOrdersRemarkEntity call({
    String? readBy,
    String? remark,
    String? remarkDate,
    String? remarkedBy,
    String? tag,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAllOrdersRemarkEntity.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAllOrdersRemarkEntity.copyWith.fieldName(...)`
class _$AllOrdersRemarkEntityCWProxyImpl
    implements _$AllOrdersRemarkEntityCWProxy {
  const _$AllOrdersRemarkEntityCWProxyImpl(this._value);

  final AllOrdersRemarkEntity _value;

  @override
  AllOrdersRemarkEntity readBy(String readBy) => this(readBy: readBy);

  @override
  AllOrdersRemarkEntity remark(String remark) => this(remark: remark);

  @override
  AllOrdersRemarkEntity remarkDate(String remarkDate) =>
      this(remarkDate: remarkDate);

  @override
  AllOrdersRemarkEntity remarkedBy(String remarkedBy) =>
      this(remarkedBy: remarkedBy);

  @override
  AllOrdersRemarkEntity tag(String tag) => this(tag: tag);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllOrdersRemarkEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllOrdersRemarkEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  AllOrdersRemarkEntity call({
    Object? readBy = const $CopyWithPlaceholder(),
    Object? remark = const $CopyWithPlaceholder(),
    Object? remarkDate = const $CopyWithPlaceholder(),
    Object? remarkedBy = const $CopyWithPlaceholder(),
    Object? tag = const $CopyWithPlaceholder(),
  }) {
    return AllOrdersRemarkEntity(
      readBy: readBy == const $CopyWithPlaceholder() || readBy == null
          ? _value.readBy
          // ignore: cast_nullable_to_non_nullable
          : readBy as String,
      remark: remark == const $CopyWithPlaceholder() || remark == null
          ? _value.remark
          // ignore: cast_nullable_to_non_nullable
          : remark as String,
      remarkDate:
          remarkDate == const $CopyWithPlaceholder() || remarkDate == null
              ? _value.remarkDate
              // ignore: cast_nullable_to_non_nullable
              : remarkDate as String,
      remarkedBy:
          remarkedBy == const $CopyWithPlaceholder() || remarkedBy == null
              ? _value.remarkedBy
              // ignore: cast_nullable_to_non_nullable
              : remarkedBy as String,
      tag: tag == const $CopyWithPlaceholder() || tag == null
          ? _value.tag
          // ignore: cast_nullable_to_non_nullable
          : tag as String,
    );
  }
}

extension $AllOrdersRemarkEntityCopyWith on AllOrdersRemarkEntity {
  /// Returns a callable class that can be used as follows: `instanceOfAllOrdersRemarkEntity.copyWith(...)` or like so:`instanceOfAllOrdersRemarkEntity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AllOrdersRemarkEntityCWProxy get copyWith =>
      _$AllOrdersRemarkEntityCWProxyImpl(this);
}
