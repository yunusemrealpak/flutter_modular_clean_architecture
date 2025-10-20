part of 'auth_bloc.dart';

/// Authentication events
@freezed
class AuthEvent with _$AuthEvent {
  /// Login event
  const factory AuthEvent.login({
    required String email,
    required String password,
  }) = AuthEventLogin;

  /// Register event
  const factory AuthEvent.register({
    required String email,
    required String password,
    required String name,
  }) = AuthEventRegister;

  /// Logout event
  const factory AuthEvent.logout() = AuthEventLogout;

  /// Check authentication status
  const factory AuthEvent.checkStatus() = AuthEventCheckStatus;

  /// Get current user
  const factory AuthEvent.getCurrentUser() = AuthEventGetCurrentUser;
}
