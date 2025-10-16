# Event Bus

Event-driven infrastructure paketi. Feature'ların birbirinden bağımsız kalmasını ve orchestrator (root) projesinin tüm koordinasyonu yapmasını sağlar.

## 🎯 Mimari Karar

### Problem
- Feature'lar birbirinin sayfalarını/route'larını bilmemeli
- Feature'lar navigation kararları vermemeli
- Feature'lar sadece "bir şey oldu" demeli
- Orchestrator (root) tüm flow'ları yönetmeli

### Çözüm: Event Bus
```
Feature A → Event Bus → Orchestrator
Feature B → Event Bus → Orchestrator
Feature C → Event Bus → Orchestrator
```

## Kurulum

```yaml
dependencies:
  event_bus:
    path: ../infrastructure/event_bus
```

## Kullanım

### 1. Feature'da Event Fırlatma (Auth Örneği)

```dart
import 'package:event_bus/event_bus.dart';

// Login başarılı olduğunda
void onLoginSuccess(AuthTokenEntity token) {
  // Feature, sadece "authentication başarılı" der
  // Nereye gidileceğine orchestrator karar verir
  EventBus.instance.publish(
    const AuthenticationSuccessEvent(
      userId: token.userId,
      isFirstLogin: false,
    ),
  );
}

// Logout olduğunda
void onLogout() {
  // Feature, sadece "logout oldu" der
  EventBus.instance.publish(
    const LogoutSuccessEvent(),
  );
}

// Session expire olduğunda
void onSessionExpired() {
  EventBus.instance.publish(
    const SessionExpiredEvent(),
  );
}
```

### 2. Orchestrator'da Event Dinleme (Root App)

```dart
import 'package:event_bus/event_bus.dart';

class AppOrchestrator {
  final EventBus _eventBus = EventBus.instance;
  late StreamSubscription _subscription;

  void initialize() {
    // Navigation event'lerini dinle
    _eventBus.on<AuthenticationSuccessEvent>(_onAuthSuccess);
    _eventBus.on<LogoutSuccessEvent>(_onLogout);
    _eventBus.on<SessionExpiredEvent>(_onSessionExpired);
    _eventBus.on<RegistrationSuccessEvent>(_onRegistrationSuccess);
  }

  void _onAuthSuccess(AuthenticationSuccessEvent event) {
    // Orchestrator karar verir
    if (event.isFirstLogin) {
      // İlk giriş ise onboarding'e git
      navigatorKey.currentState?.pushReplacementNamed('/onboarding');
    } else {
      // Normal giriş ise home'a git
      navigatorKey.currentState?.pushReplacementNamed('/home');
    }
  }

  void _onLogout(LogoutSuccessEvent event) {
    // Orchestrator karar verir
    // Tüm data'yı temizle
    clearAllData();

    // Login'e git
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      '/login',
      (route) => false,
    );
  }

  void _onSessionExpired(SessionExpiredEvent event) {
    // Orchestrator karar verir
    // Session expired dialog göster
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (_) => AlertDialog(
        title: Text('Session Expired'),
        content: Text('Please login again'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(navigatorKey.currentContext!);
              navigatorKey.currentState?.pushNamedAndRemoveUntil(
                '/login',
                (route) => false,
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onRegistrationSuccess(RegistrationSuccessEvent event) {
    // Orchestrator karar verir
    if (event.requiresEmailVerification) {
      // Email verification sayfasına git
      navigatorKey.currentState?.pushNamed(
        '/email-verification',
        arguments: {'email': event.email},
      );
    } else {
      // Direkt home'a git
      navigatorKey.currentState?.pushReplacementNamed('/home');
    }
  }

  void dispose() {
    _eventBus.clearAllHandlers();
  }
}
```

### 3. Özel Event Oluşturma

```dart
import 'package:event_bus/event_bus.dart';

// Kendi event'inizi oluşturun
class OrderCompletedEvent extends BaseEvent {
  @override
  String get eventName => 'order_completed';

  final String orderId;
  final double totalAmount;

  const OrderCompletedEvent({
    required this.orderId,
    required this.totalAmount,
  });

  @override
  Map<String, dynamic>? get payload => {
    'order_id': orderId,
    'total_amount': totalAmount,
  };
}

// Feature'da fırlat
EventBus.instance.publish(
  OrderCompletedEvent(
    orderId: '12345',
    totalAmount: 99.99,
  ),
);

// Orchestrator'da dinle
EventBus.instance.on<OrderCompletedEvent>((event) {
  // Order tamamlandı, ödeme feature'ına git
  navigatorKey.currentState?.pushNamed(
    '/payment',
    arguments: {'order_id': event.orderId},
  );
});
```

## Hazır Event'ler

### Navigation Events

#### AuthenticationSuccessEvent
```dart
const AuthenticationSuccessEvent(
  userId: 'user_123',
  isFirstLogin: false,
)
```
**Kullanım**: Login başarılı olduğunda

#### LogoutSuccessEvent
```dart
const LogoutSuccessEvent(reason: 'user_initiated')
```
**Kullanım**: Logout işlemi tamamlandığında

#### SessionExpiredEvent
```dart
const SessionExpiredEvent()
```
**Kullanım**: Token expire olduğunda

#### RegistrationSuccessEvent
```dart
const RegistrationSuccessEvent(
  userId: 'user_123',
  email: 'user@example.com',
  requiresEmailVerification: true,
)
```
**Kullanım**: Kayıt işlemi tamamlandığında

#### UnauthorizedAccessEvent
```dart
const UnauthorizedAccessEvent(
  message: 'Token invalid',
)
```
**Kullanım**: Unauthorized durumlarında

#### NavigateToFeatureEvent
```dart
const NavigateToFeatureEvent(
  featureName: 'profile',
  route: '/profile/settings',
  arguments: {'tab': 'privacy'},
)
```
**Kullanım**: Generic navigation ihtiyacında

### App Lifecycle Events

#### ShowLoadingEvent
```dart
const ShowLoadingEvent(message: 'Processing...')
```

#### ShowErrorEvent
```dart
const ShowErrorEvent(
  message: 'Something went wrong',
  title: 'Error',
)
```

#### ShowSuccessEvent
```dart
const ShowSuccessEvent(
  message: 'Operation completed successfully',
)
```

## API Reference

### EventBus

```dart
// Singleton instance
final eventBus = EventBus.instance;

// Event fırlat
eventBus.publish(MyEvent());

// Event dinle (Stream)
eventBus.subscribe<MyEvent>((event) {
  print('Event received: ${event.eventName}');
});

// Event dinle (Handler)
eventBus.on<MyEvent>((event) {
  print('Event received: ${event.eventName}');
});

// Handler kaldır
eventBus.off<MyEvent>(myHandler);

// Tüm handler'ları temizle (bir event için)
eventBus.clearHandlers<MyEvent>();

// Tüm handler'ları temizle
eventBus.clearAllHandlers();

// Event stream'i al
final stream = eventBus.streamOf<MyEvent>();
stream.listen((event) {
  print('Event: ${event.eventName}');
});
```

### BaseEvent

```dart
abstract class BaseEvent {
  String get eventName;
  Map<String, dynamic>? get payload => null;
  final DateTime timestamp;
}
```

## Best Practices

### 1. Feature'lar Navigation Kararı Vermez

❌ **YANLIŞ**:
```dart
// Feature içinde
Navigator.pushNamed(context, '/home'); // YAPMAYIN!
```

✅ **DOĞRU**:
```dart
// Feature içinde
EventBus.instance.publish(const AuthenticationSuccessEvent());
```

### 2. Event İsimlendirme

- Event isimleri past tense olmalı (bir şey OLDU)
- Açıklayıcı olmalı
- Domain-specific terimler kullanılmalı

```dart
// İyi örnekler
AuthenticationSuccessEvent
OrderCompletedEvent
PaymentProcessedEvent
UserProfileUpdatedEvent

// Kötü örnekler
AuthEvent  // Ne oldu?
GoHomeEvent  // Bu bir command, event değil
ClickEvent  // Çok generic
```

### 3. Event Payload

Minimum gerekli data gönder:
```dart
// İyi
const AuthenticationSuccessEvent(
  userId: '123',
  isFirstLogin: false,
)

// Kötü - çok fazla data
const AuthenticationSuccessEvent(
  user: entireUserObject, // Tüm user object'i gönderme
  token: tokenObject,
  settings: settingsObject,
)
```

### 4. Error Handling

Event handler'larda hata yönetimi:
```dart
EventBus.instance.on<MyEvent>((event) {
  try {
    // Handle event
  } catch (e) {
    // Log error
    // Event bus diğer handler'ları çalıştırmaya devam eder
  }
});
```

### 5. Memory Leaks

StreamSubscription'ları mutlaka dispose edin:
```dart
class MyWidget extends StatefulWidget {
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = EventBus.instance.subscribe<MyEvent>(_onMyEvent);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
```

## Örnek Flow

### Complete Authentication Flow

```dart
// 1. Auth feature - Login use case
class LoginUseCase {
  Future<Either<Failure, AuthToken>> call(LoginParams params) async {
    final result = await repository.login(params);

    return result.fold(
      (failure) => Left(failure),
      (token) {
        // Sadece event fırlat
        EventBus.instance.publish(
          AuthenticationSuccessEvent(
            userId: token.userId,
            isFirstLogin: token.isFirstLogin,
          ),
        );
        return Right(token);
      },
    );
  }
}

// 2. Auth BLoC - UI state sadece
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  Future<void> _onLogin(AuthEventLogin event, Emitter emit) async {
    emit(AuthState.loading());

    final result = await loginUseCase(LoginParams(
      email: event.email,
      password: event.password,
    ));

    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (token) => emit(AuthState.authenticated(token)),
    );
    // Navigation kararı YOK, sadece UI state
  }
}

// 3. Root App - Orchestrator
class MyApp extends StatelessWidget {
  final AppOrchestrator orchestrator = AppOrchestrator();

  @override
  Widget build(BuildContext context) {
    orchestrator.initialize();

    return MaterialApp(
      navigatorKey: navigatorKey,
      routes: {
        '/': (_) => SplashScreen(),
        '/login': (_) => LoginPage(),
        '/home': (_) => HomePage(),
        '/onboarding': (_) => OnboardingPage(),
      },
    );
  }
}
```

## Testing

```dart
test('should publish AuthenticationSuccessEvent on login success', () {
  // Arrange
  final events = <BaseEvent>[];
  EventBus.instance.subscribe<AuthenticationSuccessEvent>((event) {
    events.add(event);
  });

  // Act
  EventBus.instance.publish(const AuthenticationSuccessEvent());

  // Assert
  expect(events.length, 1);
  expect(events.first, isA<AuthenticationSuccessEvent>());
});
```

## Avantajlar

✅ **Loose Coupling**: Feature'lar birbirinden tamamen bağımsız
✅ **Testability**: Her feature ayrı test edilebilir
✅ **Scalability**: Yeni feature eklemek kolay
✅ **Maintainability**: Navigation logic tek yerde (orchestrator)
✅ **Flexibility**: Flow'lar orchestrator'da kolayca değiştirilebilir

## Lisans

Bu paket, modüler clean architecture template'inin bir parçasıdır.
