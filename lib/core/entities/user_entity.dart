import 'user_info_entity.dart';
import 'user_metadata_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.g.dart';
part 'user_entity.freezed.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String? displayName,
    required String? email,
    required bool? emailVerified,
    required bool? isAnonymous,
    required UserMetaDataEntity? metadata,
    required String? phoneNumber,
    required String? photoURL,
    required List<UserInfoEntity>? providerData,
    required String? refreshToken,
    required String? tenantId,
    required String? uid,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, Object?> json) => _$UserEntityFromJson(json);
}
