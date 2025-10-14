import 'package:envied/envied.dart';

part 'app_env.g.dart';

@Envied(path: '.env.prod', name: 'ProductionEnv')
@Envied(path: '.env.dev', name: 'DebugEnv')
final class AppEnv {
  static const bool kDebugMode = true;

  factory AppEnv() => _instance;

  static final AppEnv _instance = switch (kDebugMode) {
    true => _DebugEnv(),
    false => _ProductionEnv(),
  };

  @EnviedField(varName: 'API_BASE_URL')
  final String apiBaseUrl = _instance.apiBaseUrl;

  @EnviedField(varName: 'API_KEY', obfuscate: true)
  final String apiKey = _instance.apiKey;

  @EnviedField(varName: 'API_TIMEOUT')
  final int apiTimeout = _instance.apiTimeout;

  @EnviedField(varName: 'APP_NAME')
  final String appName = _instance.appName;

  @EnviedField(varName: 'APP_VERSION')
  final String appVersion = _instance.appVersion;

  @EnviedField(varName: 'ENABLE_LOGGING')
  final bool enableLogging = _instance.enableLogging;

  @EnviedField(varName: 'ENABLE_ANALYTICS')
  final bool enableAnalytics = _instance.enableAnalytics;
}

/*
API_BASE_URL=https://dev-api.example.com
API_KEY=dev_your_api_key_here
API_TIMEOUT=30

# App Configuration
APP_NAME=MyApp Dev
APP_VERSION=1.0.0

# Feature Flags
ENABLE_LOGGING=true
ENABLE_ANALYTICS=false
*/
