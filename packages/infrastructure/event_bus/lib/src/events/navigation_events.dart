import '../base_event.dart';

/// Base navigation event
/// Feature'lar bu event'i kullanarak orchestrator'a navigasyon ihtiyacını bildirir
abstract class NavigationEvent extends BaseEvent {
  const NavigationEvent();
}

/// Event fired when authentication is successful
/// Orchestrator decides where to navigate (home, onboarding, etc.)
class AuthenticationSuccessEvent extends NavigationEvent {
  @override
  String get eventName => 'authentication_success';

  final String? userId;
  final bool isFirstLogin;

  const AuthenticationSuccessEvent({
    this.userId,
    this.isFirstLogin = false,
  });

  @override
  Map<String, dynamic>? get payload => {
        'user_id': userId,
        'is_first_login': isFirstLogin,
      };
}

/// Event fired when user logs out
/// Orchestrator decides navigation (login, splash, etc.)
class LogoutSuccessEvent extends NavigationEvent {
  @override
  String get eventName => 'logout_success';

  final String? reason;

  const LogoutSuccessEvent({this.reason});

  @override
  Map<String, dynamic>? get payload => {
        'reason': reason,
      };
}

/// Event fired when session expires
/// Orchestrator handles session expiry (show dialog, navigate to login, etc.)
class SessionExpiredEvent extends NavigationEvent {
  @override
  String get eventName => 'session_expired';

  const SessionExpiredEvent();
}

/// Event fired when user needs to complete profile
/// Orchestrator navigates to profile completion flow
class ProfileCompletionRequiredEvent extends NavigationEvent {
  @override
  String get eventName => 'profile_completion_required';

  final String userId;
  final List<String> missingFields;

  const ProfileCompletionRequiredEvent({
    required this.userId,
    required this.missingFields,
  });

  @override
  Map<String, dynamic>? get payload => {
        'user_id': userId,
        'missing_fields': missingFields,
      };
}

/// Event fired when user registration is successful
/// Orchestrator decides next step (email verification, onboarding, etc.)
class RegistrationSuccessEvent extends NavigationEvent {
  @override
  String get eventName => 'registration_success';

  final String userId;
  final String email;
  final bool requiresEmailVerification;

  const RegistrationSuccessEvent({
    required this.userId,
    required this.email,
    this.requiresEmailVerification = true,
  });

  @override
  Map<String, dynamic>? get payload => {
        'user_id': userId,
        'email': email,
        'requires_email_verification': requiresEmailVerification,
      };
}

/// Event fired when unauthorized access is detected
/// Orchestrator handles unauthorized state (clear data, navigate to login)
class UnauthorizedAccessEvent extends NavigationEvent {
  @override
  String get eventName => 'unauthorized_access';

  final String? message;

  const UnauthorizedAccessEvent({this.message});

  @override
  Map<String, dynamic>? get payload => {
        'message': message,
      };
}

/// Event fired when navigation to a specific feature is requested
/// This is a generic event that can be used by any feature
/// Orchestrator interprets the destination and performs navigation
class NavigateToFeatureEvent extends NavigationEvent {
  @override
  String get eventName => 'navigate_to_feature';

  final String featureName;
  final String? route;
  final Map<String, dynamic>? arguments;
  final bool replace;

  const NavigateToFeatureEvent({
    required this.featureName,
    this.route,
    this.arguments,
    this.replace = false,
  });

  @override
  Map<String, dynamic>? get payload => {
        'feature_name': featureName,
        'route': route,
        'arguments': arguments,
        'replace': replace,
      };
}

/// Event fired to pop current route
/// Orchestrator handles back navigation
class PopRouteEvent extends NavigationEvent {
  @override
  String get eventName => 'pop_route';

  final dynamic result;

  const PopRouteEvent({this.result});

  @override
  Map<String, dynamic>? get payload => {
        'result': result,
      };
}
