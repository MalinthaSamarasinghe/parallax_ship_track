import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_entity.g.dart';
part 'user_info_entity.freezed.dart';

@freezed
class UserInfoEntity with _$UserInfoEntity {
  const factory UserInfoEntity({
    required String? displayName,
    required String? email,
    required String? phoneNumber,
    required String? photoURL,
    /// ID of the provider (google.com, apple.com, etc.)
    required String? providerId,
    /// UID specific to the provider
    required String? uid,
  }) = _UserInfoEntity;

  factory UserInfoEntity.fromJson(Map<String, Object?> json) => _$UserInfoEntityFromJson(json);
}
