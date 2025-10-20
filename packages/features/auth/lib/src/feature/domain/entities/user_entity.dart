import 'package:equatable/equatable.dart';

/// User entity representing an authenticated user
class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? avatar;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const UserEntity({
    required this.id,
    required this.email,
    this.name,
    this.avatar,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, email, name, avatar, createdAt, updatedAt];

  @override
  String toString() {
    return 'UserEntity(id: $id, email: $email, name: $name)';
  }
}
