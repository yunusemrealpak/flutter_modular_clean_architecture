import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// User model wrapper
/// Wraps the freezed model and provides entity conversion
class UserModel {
  final UserModelData data;

  const UserModel(this.data);

  /// Convert to entity
  UserEntity toEntity() {
    return UserEntity(
      id: data.id,
      email: data.email,
      name: data.name,
      avatar: data.avatar,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }

  /// Create from entity
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      UserModelData(
        id: entity.id,
        email: entity.email,
        name: entity.name,
        avatar: entity.avatar,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      ),
    );
  }

  /// Create from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(UserModelData.fromJson(json));
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => data.toJson();
}

/// User model data with freezed
@freezed
abstract class UserModelData with _$UserModelData {
  const factory UserModelData({
    required String id,
    required String email,
    String? name,
    String? avatar,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _UserModelData;

  factory UserModelData.fromJson(Map<String, dynamic> json) =>
      _$UserModelDataFromJson(json);
}
