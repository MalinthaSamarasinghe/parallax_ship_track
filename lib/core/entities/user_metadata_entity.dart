import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_metadata_entity.g.dart';
part 'user_metadata_entity.freezed.dart';

@freezed
class UserMetaDataEntity with _$UserMetaDataEntity {
  const factory UserMetaDataEntity({
    required DateTime? creationTimestamp,
    required DateTime? lastSignInTime,
  }) = _UserMetaDataEntity;

  factory UserMetaDataEntity.fromJson(Map<String, Object?> json) => _$UserMetaDataEntityFromJson(json);
}
