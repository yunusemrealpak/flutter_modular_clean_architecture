part of 'auth_bloc.dart';

/// Authentication states
@freezed
class AuthState with _$AuthState {
  /// Initial state
  const factory AuthState.initial() = AuthStateInitial;

  /// Loading state
  const factory AuthState.loading() = AuthStateLoading;

  /// Authenticated state
  const factory AuthState.authenticated(AuthTokenEntity? token) =
      AuthStateAuthenticated;

  /// Unauthenticated state
  const factory AuthState.unauthenticated() = AuthStateUnauthenticated;

  /// User loaded state
  const factory AuthState.userLoaded(UserEntity user) = AuthStateUserLoaded;

  /// Error state
  const factory AuthState.error(String message) = AuthStateError;
}
