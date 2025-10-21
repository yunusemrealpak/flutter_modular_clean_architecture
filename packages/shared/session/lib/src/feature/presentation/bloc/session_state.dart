part of 'session_bloc.dart';

@freezed
class SessionState with _$SessionState {
  const factory SessionState.initial() = SessionStateInitial;
  const factory SessionState.authenticated(SessionData session) =
      SessionStateAuthenticated;
  const factory SessionState.unauthenticated() = SessionStateUnauthenticated;
}
