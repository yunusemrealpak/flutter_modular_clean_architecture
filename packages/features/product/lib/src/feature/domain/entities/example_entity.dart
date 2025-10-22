import 'package:equatable/equatable.dart';

/// Example entity representing a domain object
/// This is a pure Dart class with no external dependencies
class ExampleEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const ExampleEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, name, description, createdAt, updatedAt];

  @override
  String toString() {
    return 'ExampleEntity(id: $id, name: $name, description: $description)';
  }

  /// Example business logic method
  bool get isRecent {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    return difference.inDays < 7;
  }
}
