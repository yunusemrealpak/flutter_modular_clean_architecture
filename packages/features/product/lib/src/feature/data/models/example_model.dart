import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/example_entity.dart';

part 'example_model.freezed.dart';
part 'example_model.g.dart';

/// Example model wrapper
/// Wraps the freezed model and provides entity conversion
class ExampleModel {
  final ExampleModelData data;

  const ExampleModel(this.data);

  /// Convert model to entity
  ExampleEntity toEntity() {
    return ExampleEntity(
      id: data.id,
      name: data.name,
      description: data.description,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }

  /// Create model from entity
  factory ExampleModel.fromEntity(ExampleEntity entity) {
    return ExampleModel(
      ExampleModelData(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      ),
    );
  }

  /// Create model from JSON
  factory ExampleModel.fromJson(Map<String, dynamic> json) {
    return ExampleModel(ExampleModelData.fromJson(json));
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() => data.toJson();
}

/// Example model data with freezed
/// Handles JSON serialization and immutability
@freezed
abstract class ExampleModelData with _$ExampleModelData {
  const factory ExampleModelData({
    required String id,
    required String name,
    required String description,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ExampleModelData;

  factory ExampleModelData.fromJson(Map<String, dynamic> json) =>
      _$ExampleModelDataFromJson(json);
}
