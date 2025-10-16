import '../base_event.dart';

/// Base app lifecycle event
abstract class AppLifecycleEvent extends BaseEvent {
  const AppLifecycleEvent();
}

/// Event fired when app is initialized
class AppInitializedEvent extends AppLifecycleEvent {
  @override
  String get eventName => 'app_initialized';

  const AppInitializedEvent();
}

/// Event fired when app needs to show loading state
class ShowLoadingEvent extends AppLifecycleEvent {
  @override
  String get eventName => 'show_loading';

  final String? message;

  const ShowLoadingEvent({this.message});

  @override
  Map<String, dynamic>? get payload => {
        'message': message,
      };
}

/// Event fired when app needs to hide loading state
class HideLoadingEvent extends AppLifecycleEvent {
  @override
  String get eventName => 'hide_loading';

  const HideLoadingEvent();
}

/// Event fired when app needs to show error
class ShowErrorEvent extends AppLifecycleEvent {
  @override
  String get eventName => 'show_error';

  final String message;
  final String? title;
  final String? code;

  const ShowErrorEvent({
    required this.message,
    this.title,
    this.code,
  });

  @override
  Map<String, dynamic>? get payload => {
        'message': message,
        'title': title,
        'code': code,
      };
}

/// Event fired when app needs to show success message
class ShowSuccessEvent extends AppLifecycleEvent {
  @override
  String get eventName => 'show_success';

  final String message;
  final String? title;

  const ShowSuccessEvent({
    required this.message,
    this.title,
  });

  @override
  Map<String, dynamic>? get payload => {
        'message': message,
        'title': title,
      };
}

/// Event fired when app configuration changes
class ConfigurationChangedEvent extends AppLifecycleEvent {
  @override
  String get eventName => 'configuration_changed';

  final String key;
  final dynamic value;

  const ConfigurationChangedEvent({
    required this.key,
    required this.value,
  });

  @override
  Map<String, dynamic>? get payload => {
        'key': key,
        'value': value,
      };
}
