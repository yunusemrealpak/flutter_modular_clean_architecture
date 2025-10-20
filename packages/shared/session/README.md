# Session Package

Simple in-memory session management with BLoC pattern for modular Flutter apps.

## Features

- ✅ In-memory session state management
- ✅ BLoC pattern for reactive UI updates
- ✅ Minimal and lightweight
- ✅ Type-safe with Freezed models
- ✅ Injectable for dependency injection

## Structure

```
lib/
├── src/
│   ├── domain/
│   │   └── models/
│   │       ├── session_data.dart      # Session data model
│   │       └── user_session.dart      # User model
│   └── presentation/
│       └── bloc/
│           ├── session_bloc.dart      # BLoC
│           ├── session_event.dart     # Events
│           └── session_state.dart     # States
└── session.dart                       # Barrel export
```

## Usage

### 1. Setup in Root App

```dart
// app/root/lib/main.dart
import 'package:session/session.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SessionBloc>(
          create: (_) => di<SessionBloc>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}
```

### 2. Login (Auth Feature)

```dart
// Feature: Auth
import 'package:session/session.dart';

class LoginUseCase {
  final SessionBloc _sessionBloc;

  Future<Either<Failure, void>> call(LoginParams params) async {
    final result = await _authRepo.login(params);

    return result.fold(
      (failure) => Left(failure),
      (authResponse) {
        // Map to UserSession
        final userSession = UserSession(
          id: authResponse.user.id,
          email: authResponse.user.email,
          name: authResponse.user.name,
          avatar: authResponse.user.avatar,
        );

        // Update session
        _sessionBloc.add(SessionEvent.login(
          user: userSession,
          accessToken: authResponse.accessToken,
          refreshToken: authResponse.refreshToken,
        ));

        return const Right(null);
      },
    );
  }
}
```

### 3. Read Session (Any Feature)

```dart
// Any feature - Widget
import 'package:session/session.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        return state.when(
          initial: () => SplashScreen(),
          authenticated: (session) => WelcomeView(
            userName: session.user.name,
          ),
          unauthenticated: () => LoginPrompt(),
        );
      },
    );
  }
}
```

### 4. Access Current User

```dart
// Extension for convenience
extension SessionBlocX on BuildContext {
  SessionBloc get session => read<SessionBloc>();

  UserSession? get currentUser => session.currentUser;

  bool get isAuthenticated => session.isAuthenticated;
}

// Usage
class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.currentUser;

    if (user == null) return SizedBox.shrink();

    return Text('Hello, ${user.name}!');
  }
}
```

### 5. Logout

```dart
void logout(BuildContext context) {
  context.session.add(const SessionEvent.logout());
}
```

### 6. Update User Info

```dart
void updateUserName(BuildContext context, String newName) {
  final currentUser = context.currentUser;
  if (currentUser == null) return;

  final updatedUser = currentUser.copyWith(name: newName);

  context.session.add(SessionEvent.updateUser(user: updatedUser));
}
```

## Models

### UserSession

```dart
UserSession(
  id: 'user_123',
  email: 'user@example.com',
  name: 'John Doe',
  avatar: 'https://...',
  roles: ['user', 'admin'],
  metadata: {'key': 'value'},
)
```

### SessionData

```dart
SessionData(
  user: userSession,
  accessToken: 'token_here',
  refreshToken: 'refresh_token',
  isAuthenticated: true,
  settings: {'theme': 'dark'},
  lastActivity: DateTime.now(),
)
```

## Events

- `SessionEvent.login()` - User login
- `SessionEvent.logout()` - User logout
- `SessionEvent.updateUser()` - Update user info
- `SessionEvent.updateSettings()` - Update app settings
- `SessionEvent.refreshToken()` - Refresh auth token

## States

- `SessionState.initial()` - Initial state
- `SessionState.authenticated(session)` - User authenticated
- `SessionState.unauthenticated()` - User not authenticated

## Code Generation

Run code generation after any model changes:

```bash
cd packages/shared/session
dart run build_runner build --delete-conflicting-outputs
```

## Best Practices

1. ✅ **UI Access**: ALWAYS use `BlocBuilder<SessionBloc>` in widgets
2. ✅ **Feature Mapping**: Map feature's UserEntity → UserSession before updating session
3. ✅ **Single Source**: SessionBloc is the single source of truth for session state
4. ✅ **Reactive**: UI automatically updates when session changes

## Notes

- This is an **in-memory** session package
- Session is **NOT persisted** (cleared on app restart)
- For persistence, add storage package integration in auth feature
- Session state is managed purely by BLoC
