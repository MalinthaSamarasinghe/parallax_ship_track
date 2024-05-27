// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_metadata_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserMetaDataEntityImpl _$$UserMetaDataEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$UserMetaDataEntityImpl(
      creationTimestamp: json['creationTimestamp'] == null
          ? null
          : DateTime.parse(json['creationTimestamp'] as String),
      lastSignInTime: json['lastSignInTime'] == null
          ? null
          : DateTime.parse(json['lastSignInTime'] as String),
    );

Map<String, dynamic> _$$UserMetaDataEntityImplToJson(
        _$UserMetaDataEntityImpl instance) =>
    <String, dynamic>{
      'creationTimestamp': instance.creationTimestamp?.toIso8601String(),
      'lastSignInTime': instance.lastSignInTime?.toIso8601String(),
    };
