// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_info_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserInfoEntity _$UserInfoEntityFromJson(Map<String, dynamic> json) {
  return _UserInfoEntity.fromJson(json);
}

/// @nodoc
mixin _$UserInfoEntity {
  String? get displayName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get photoURL => throw _privateConstructorUsedError;

  /// ID of the provider (google.com, apple.com, etc.)
  String? get providerId => throw _privateConstructorUsedError;

  /// UID specific to the provider
  String? get uid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserInfoEntityCopyWith<UserInfoEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoEntityCopyWith<$Res> {
  factory $UserInfoEntityCopyWith(
          UserInfoEntity value, $Res Function(UserInfoEntity) then) =
      _$UserInfoEntityCopyWithImpl<$Res, UserInfoEntity>;
  @useResult
  $Res call(
      {String? displayName,
      String? email,
      String? phoneNumber,
      String? photoURL,
      String? providerId,
      String? uid});
}

/// @nodoc
class _$UserInfoEntityCopyWithImpl<$Res, $Val extends UserInfoEntity>
    implements $UserInfoEntityCopyWith<$Res> {
  _$UserInfoEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? photoURL = freezed,
    Object? providerId = freezed,
    Object? uid = freezed,
  }) {
    return _then(_value.copyWith(
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      providerId: freezed == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserInfoEntityImplCopyWith<$Res>
    implements $UserInfoEntityCopyWith<$Res> {
  factory _$$UserInfoEntityImplCopyWith(_$UserInfoEntityImpl value,
          $Res Function(_$UserInfoEntityImpl) then) =
      __$$UserInfoEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? displayName,
      String? email,
      String? phoneNumber,
      String? photoURL,
      String? providerId,
      String? uid});
}

/// @nodoc
class __$$UserInfoEntityImplCopyWithImpl<$Res>
    extends _$UserInfoEntityCopyWithImpl<$Res, _$UserInfoEntityImpl>
    implements _$$UserInfoEntityImplCopyWith<$Res> {
  __$$UserInfoEntityImplCopyWithImpl(
      _$UserInfoEntityImpl _value, $Res Function(_$UserInfoEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? photoURL = freezed,
    Object? providerId = freezed,
    Object? uid = freezed,
  }) {
    return _then(_$UserInfoEntityImpl(
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      providerId: freezed == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserInfoEntityImpl implements _UserInfoEntity {
  const _$UserInfoEntityImpl(
      {required this.displayName,
      required this.email,
      required this.phoneNumber,
      required this.photoURL,
      required this.providerId,
      required this.uid});

  factory _$UserInfoEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserInfoEntityImplFromJson(json);

  @override
  final String? displayName;
  @override
  final String? email;
  @override
  final String? phoneNumber;
  @override
  final String? photoURL;

  /// ID of the provider (google.com, apple.com, etc.)
  @override
  final String? providerId;

  /// UID specific to the provider
  @override
  final String? uid;

  @override
  String toString() {
    return 'UserInfoEntity(displayName: $displayName, email: $email, phoneNumber: $phoneNumber, photoURL: $photoURL, providerId: $providerId, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserInfoEntityImpl &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.photoURL, photoURL) ||
                other.photoURL == photoURL) &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, displayName, email, phoneNumber, photoURL, providerId, uid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserInfoEntityImplCopyWith<_$UserInfoEntityImpl> get copyWith =>
      __$$UserInfoEntityImplCopyWithImpl<_$UserInfoEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserInfoEntityImplToJson(
      this,
    );
  }
}

abstract class _UserInfoEntity implements UserInfoEntity {
  const factory _UserInfoEntity(
      {required final String? displayName,
      required final String? email,
      required final String? phoneNumber,
      required final String? photoURL,
      required final String? providerId,
      required final String? uid}) = _$UserInfoEntityImpl;

  factory _UserInfoEntity.fromJson(Map<String, dynamic> json) =
      _$UserInfoEntityImpl.fromJson;

  @override
  String? get displayName;
  @override
  String? get email;
  @override
  String? get phoneNumber;
  @override
  String? get photoURL;
  @override

  /// ID of the provider (google.com, apple.com, etc.)
  String? get providerId;
  @override

  /// UID specific to the provider
  String? get uid;
  @override
  @JsonKey(ignore: true)
  _$$UserInfoEntityImplCopyWith<_$UserInfoEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
