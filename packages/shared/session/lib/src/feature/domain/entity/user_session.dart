import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_session.freezed.dart';

/// Lightweight user session model
/// Contains essential user information shared across the app
@freezed
abstract class UserSession with _$UserSession {
  const factory UserSession({
    /// User unique identifier
    required String id,

    /// User email address
    required String email,

    /// User display name
    required String name,

    /// User avatar URL (optional)
    String? avatar,

    /// User roles for authorization
    @Default([]) List<String> roles,

    /// Flexible metadata for additional info
    Map<String, dynamic>? metadata,
  }) = _UserSession;
}
