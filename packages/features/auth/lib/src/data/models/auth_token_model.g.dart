// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthTokenModelData _$AuthTokenModelDataFromJson(Map<String, dynamic> json) =>
    _AuthTokenModelData(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      tokenType: json['token_type'] as String,
      expiresIn: (json['expires_in'] as num).toInt(),
      issuedAt: DateTime.parse(json['issued_at'] as String),
    );

Map<String, dynamic> _$AuthTokenModelDataToJson(_AuthTokenModelData instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
      'issued_at': instance.issuedAt.toIso8601String(),
    };
