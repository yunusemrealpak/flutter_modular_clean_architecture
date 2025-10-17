import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/auth_token_entity.dart';

part 'auth_token_model.freezed.dart';
part 'auth_token_model.g.dart';

/// Auth token model wrapper
/// Wraps the freezed model and provides entity conversion
class AuthTokenModel {
  final AuthTokenModelData data;

  const AuthTokenModel(this.data);

  /// Convert to entity
  AuthTokenEntity toEntity() {
    return AuthTokenEntity(
      accessToken: data.accessToken,
      refreshToken: data.refreshToken,
      tokenType: data.tokenType,
      expiresIn: data.expiresIn,
      issuedAt: data.issuedAt,
    );
  }

  /// Create from entity
  factory AuthTokenModel.fromEntity(AuthTokenEntity entity) {
    return AuthTokenModel(
      AuthTokenModelData(
        accessToken: entity.accessToken,
        refreshToken: entity.refreshToken,
        tokenType: entity.tokenType,
        expiresIn: entity.expiresIn,
        issuedAt: entity.issuedAt,
      ),
    );
  }

  /// Create from JSON
  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(AuthTokenModelData.fromJson(json));
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => data.toJson();
}

/// Auth token model data with freezed
@freezed
abstract class AuthTokenModelData with _$AuthTokenModelData {
  const factory AuthTokenModelData({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
    @JsonKey(name: 'token_type') required String tokenType,
    @JsonKey(name: 'expires_in') required int expiresIn,
    @JsonKey(name: 'issued_at') required DateTime issuedAt,
  }) = _AuthTokenModelData;

  factory AuthTokenModelData.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenModelDataFromJson(json);
}
