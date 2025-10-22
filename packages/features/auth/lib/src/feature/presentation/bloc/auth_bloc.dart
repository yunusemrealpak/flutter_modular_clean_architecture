import 'package:core/core.dart';
import 'package:event_bus/event_bus.dart';
import 'package:session/session.dart';

import '../../domain/entities/auth_token_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/check_auth_status_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

/// Authentication BLoC
/// Manages authentication state (UI state only)
/// Business logic is handled by use cases
@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final CheckAuthStatusUseCase checkAuthStatusUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
    required this.checkAuthStatusUseCase,
  }) : super(const AuthState.initial()) {
    on<AuthEventLogin>(_onLogin);
    on<AuthEventRegister>(_onRegister);
    on<AuthEventLogout>(_onLogout);
    on<AuthEventCheckStatus>(_onCheckStatus);
    on<AuthEventGetCurrentUser>(_onGetCurrentUser);
  }

  Future<void> _onLogin(AuthEventLogin event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    final result = await loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );

    result.fold((failure) => emit(AuthState.error(failure.message)), (token) {
      di<SessionBloc>().add(
        SessionEvent.login(
          user: UserSession(id: "1", email: "email", name: "name"),
          accessToken: token.accessToken,
        ),
      );
      // Orchestrator decides where to navigate
      EventBus.I.publish(
        const AuthenticationSuccessEvent(
          isFirstLogin: false, // TODO: Determine from token or user data
        ),
      );
      emit(AuthState.authenticated(token));
    });
  }

  Future<void> _onRegister(
    AuthEventRegister event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    final result = await registerUseCase(
      RegisterParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );

    result.fold((failure) => emit(AuthState.error(failure.message)), (token) {
      // Feature says: "registration successful"
      // Orchestrator decides where to navigate (email verification, home, etc.)
      EventBus.I.publish(
        RegistrationSuccessEvent(
          userId: token.accessToken,
          email: event.email,
          requiresEmailVerification: false, // TODO: Determine from response
        ),
      );
      emit(AuthState.authenticated(token));
    });
  }

  Future<void> _onLogout(AuthEventLogout event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    final result = await logoutUseCase(const NoParams());

    result.fold((failure) => emit(AuthState.error(failure.message)), (_) {
      // Feature says: "logout successful"
      // Orchestrator decides where to navigate (clear data, go to login, etc.)
      EventBus.I.publish(const LogoutSuccessEvent(reason: 'user_initiated'));
      emit(const AuthState.unauthenticated());
    });
  }

  Future<void> _onCheckStatus(
    AuthEventCheckStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    final result = await checkAuthStatusUseCase(const NoParams());

    result.fold((failure) => emit(const AuthState.unauthenticated()), (
      isAuthenticated,
    ) {
      if (isAuthenticated) {
        emit(const AuthState.authenticated(null));
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
  }

  Future<void> _onGetCurrentUser(
    AuthEventGetCurrentUser event,
    Emitter<AuthState> emit,
  ) async {
    final result = await getCurrentUserUseCase(const NoParams());

    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (user) => emit(AuthState.userLoaded(user)),
    );
  }
}
