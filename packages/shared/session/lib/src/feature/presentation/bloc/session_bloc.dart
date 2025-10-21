import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:session/src/feature/domain/entity/session_data.dart';
import 'package:session/src/feature/domain/entity/user_session.dart';

part 'session_bloc.freezed.dart';
part 'session_event.dart';
part 'session_state.dart';

@lazySingleton
class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc() : super(const SessionState.initial()) {
    on<SessionEventLogin>(_onLogin);
    on<SessionEventLogout>(_onLogout);
    on<SessionEventUpdateUser>(_onUpdateUser);
    on<SessionEventUpdateSettings>(_onUpdateSettings);
    on<SessionEventRefreshToken>(_onRefreshToken);
  }

  // Current session data (cached for easy access)
  SessionData? get currentSession =>
      state.maybeWhen(authenticated: (session) => session, orElse: () => null);

  // Current user (helper getter)
  UserSession? get currentUser => currentSession?.user;

  // Access token (helper getter)
  String? get accessToken => currentSession?.accessToken;

  // Authentication status (helper getter)
  bool get isAuthenticated =>
      state.maybeWhen(authenticated: (_) => true, orElse: () => false);

  Future<void> _onLogin(
    SessionEventLogin event,
    Emitter<SessionState> emit,
  ) async {
    final session = SessionData(
      user: event.user,
      accessToken: event.accessToken,
      refreshToken: event.refreshToken,
      isAuthenticated: true,
      lastActivity: DateTime.now(),
    );

    emit(SessionState.authenticated(session));
  }

  Future<void> _onLogout(
    SessionEventLogout event,
    Emitter<SessionState> emit,
  ) async {
    emit(const SessionState.unauthenticated());
  }

  Future<void> _onUpdateUser(
    SessionEventUpdateUser event,
    Emitter<SessionState> emit,
  ) async {
    await state.maybeWhen(
      authenticated: (session) async {
        final updatedSession = session.copyWith(user: event.user);
        emit(SessionState.authenticated(updatedSession));
      },
      orElse: () {},
    );
  }

  Future<void> _onUpdateSettings(
    SessionEventUpdateSettings event,
    Emitter<SessionState> emit,
  ) async {
    await state.maybeWhen(
      authenticated: (session) async {
        final updatedSettings = {...session.settings, ...event.settings};
        final updatedSession = session.copyWith(settings: updatedSettings);
        emit(SessionState.authenticated(updatedSession));
      },
      orElse: () {},
    );
  }

  Future<void> _onRefreshToken(
    SessionEventRefreshToken event,
    Emitter<SessionState> emit,
  ) async {
    await state.maybeWhen(
      authenticated: (session) async {
        final updatedSession = session.copyWith(
          accessToken: event.accessToken,
          refreshToken: event.refreshToken,
        );
        emit(SessionState.authenticated(updatedSession));
      },
      orElse: () {},
    );
  }
}
