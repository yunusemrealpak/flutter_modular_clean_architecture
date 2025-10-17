final class AuthRoutes {
  static AuthRoutes? _instance;
  factory AuthRoutes() => _instance ??= AuthRoutes._();
  AuthRoutes._();

  String get login => '/login';
  String get register => '/register';
  String get forgotPassword => '/forgot-password';
}
