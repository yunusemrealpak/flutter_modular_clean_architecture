import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:session/src/feature/domain/entity/user_session.dart';

part 'session_data.freezed.dart';

/// Session data model containing user info and authentication state
@freezed
abstract class SessionData with _$SessionData {
  const factory SessionData({
    /// Current authenticated user
    UserSession? user,

    /// Access token
    String? accessToken,

    /// Refresh token
    String? refreshToken,

    /// Authentication status
    @Default(false) bool isAuthenticated,

    /// App settings
    @Default({}) Map<String, dynamic> settings,

    /// Last activity timestamp
    DateTime? lastActivity,
  }) = _SessionData;
}
