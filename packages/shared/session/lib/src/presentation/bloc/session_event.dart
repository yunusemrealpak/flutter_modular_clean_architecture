part of 'session_bloc.dart';

@freezed
class SessionEvent with _$SessionEvent {
  /// User logged in
  const factory SessionEvent.login({
    required UserSession user,
    required String accessToken,
    String? refreshToken,
  }) = SessionEventLogin;

  /// User logged out
  const factory SessionEvent.logout() = SessionEventLogout;

  /// Update user information
  const factory SessionEvent.updateUser({
    required UserSession user,
  }) = SessionEventUpdateUser;

  /// Update app settings
  const factory SessionEvent.updateSettings({
    required Map<String, dynamic> settings,
  }) = SessionEventUpdateSettings;

  /// Refresh authentication token
  const factory SessionEvent.refreshToken({
    required String accessToken,
    String? refreshToken,
  }) = SessionEventRefreshToken;
}
