// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_metadata_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserMetaDataEntity _$UserMetaDataEntityFromJson(Map<String, dynamic> json) {
  return _UserMetaDataEntity.fromJson(json);
}

/// @nodoc
mixin _$UserMetaDataEntity {
  DateTime? get creationTimestamp => throw _privateConstructorUsedError;
  DateTime? get lastSignInTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserMetaDataEntityCopyWith<UserMetaDataEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserMetaDataEntityCopyWith<$Res> {
  factory $UserMetaDataEntityCopyWith(
          UserMetaDataEntity value, $Res Function(UserMetaDataEntity) then) =
      _$UserMetaDataEntityCopyWithImpl<$Res, UserMetaDataEntity>;
  @useResult
  $Res call({DateTime? creationTimestamp, DateTime? lastSignInTime});
}

/// @nodoc
class _$UserMetaDataEntityCopyWithImpl<$Res, $Val extends UserMetaDataEntity>
    implements $UserMetaDataEntityCopyWith<$Res> {
  _$UserMetaDataEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? creationTimestamp = freezed,
    Object? lastSignInTime = freezed,
  }) {
    return _then(_value.copyWith(
      creationTimestamp: freezed == creationTimestamp
          ? _value.creationTimestamp
          : creationTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSignInTime: freezed == lastSignInTime
          ? _value.lastSignInTime
          : lastSignInTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserMetaDataEntityImplCopyWith<$Res>
    implements $UserMetaDataEntityCopyWith<$Res> {
  factory _$$UserMetaDataEntityImplCopyWith(_$UserMetaDataEntityImpl value,
          $Res Function(_$UserMetaDataEntityImpl) then) =
      __$$UserMetaDataEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime? creationTimestamp, DateTime? lastSignInTime});
}

/// @nodoc
class __$$UserMetaDataEntityImplCopyWithImpl<$Res>
    extends _$UserMetaDataEntityCopyWithImpl<$Res, _$UserMetaDataEntityImpl>
    implements _$$UserMetaDataEntityImplCopyWith<$Res> {
  __$$UserMetaDataEntityImplCopyWithImpl(_$UserMetaDataEntityImpl _value,
      $Res Function(_$UserMetaDataEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? creationTimestamp = freezed,
    Object? lastSignInTime = freezed,
  }) {
    return _then(_$UserMetaDataEntityImpl(
      creationTimestamp: freezed == creationTimestamp
          ? _value.creationTimestamp
          : creationTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSignInTime: freezed == lastSignInTime
          ? _value.lastSignInTime
          : lastSignInTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserMetaDataEntityImpl implements _UserMetaDataEntity {
  const _$UserMetaDataEntityImpl(
      {required this.creationTimestamp, required this.lastSignInTime});

  factory _$UserMetaDataEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserMetaDataEntityImplFromJson(json);

  @override
  final DateTime? creationTimestamp;
  @override
  final DateTime? lastSignInTime;

  @override
  String toString() {
    return 'UserMetaDataEntity(creationTimestamp: $creationTimestamp, lastSignInTime: $lastSignInTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserMetaDataEntityImpl &&
            (identical(other.creationTimestamp, creationTimestamp) ||
                other.creationTimestamp == creationTimestamp) &&
            (identical(other.lastSignInTime, lastSignInTime) ||
                other.lastSignInTime == lastSignInTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, creationTimestamp, lastSignInTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserMetaDataEntityImplCopyWith<_$UserMetaDataEntityImpl> get copyWith =>
      __$$UserMetaDataEntityImplCopyWithImpl<_$UserMetaDataEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserMetaDataEntityImplToJson(
      this,
    );
  }
}

abstract class _UserMetaDataEntity implements UserMetaDataEntity {
  const factory _UserMetaDataEntity(
      {required final DateTime? creationTimestamp,
      required final DateTime? lastSignInTime}) = _$UserMetaDataEntityImpl;

  factory _UserMetaDataEntity.fromJson(Map<String, dynamic> json) =
      _$UserMetaDataEntityImpl.fromJson;

  @override
  DateTime? get creationTimestamp;
  @override
  DateTime? get lastSignInTime;
  @override
  @JsonKey(ignore: true)
  _$$UserMetaDataEntityImplCopyWith<_$UserMetaDataEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
