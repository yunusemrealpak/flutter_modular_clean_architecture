final class AppShellRoutes {
  static AppShellRoutes? _instance;
  factory AppShellRoutes() => _instance ??= AppShellRoutes._();
  const AppShellRoutes._();

  String get appShell => '/app';
  String get homeTab => 'homeTab';
  String get profileTab => 'profileTab';
}
