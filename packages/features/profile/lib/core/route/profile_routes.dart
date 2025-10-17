final class ProfileRoutes {
  static ProfileRoutes? _instance;
  factory ProfileRoutes() => _instance ??= ProfileRoutes._();
  ProfileRoutes._();

  String get profile => 'profile';
}
