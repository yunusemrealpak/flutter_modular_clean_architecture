/// API endpoint constants
class ApiEndpoints {
  ApiEndpoints._();

  // Authentication
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyEmail = '/auth/verify-email';

  // User
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/profile';
  static const String changePassword = '/user/change-password';
  static const String deleteAccount = '/user/delete';
  static const String uploadAvatar = '/user/avatar';

  // Users (Admin)
  static const String users = '/users';
  static String userById(String id) => '/users/$id';
  static String userPosts(String userId) => '/users/$userId/posts';

  // Posts
  static const String posts = '/posts';
  static String postById(String id) => '/posts/$id';
  static String postComments(String postId) => '/posts/$postId/comments';

  // Comments
  static const String comments = '/comments';
  static String commentById(String id) => '/comments/$id';

  // Settings
  static const String settings = '/settings';
  static const String updateSettings = '/settings';

  // Notifications
  static const String notifications = '/notifications';
  static String notificationById(String id) => '/notifications/$id';
  static const String markAsRead = '/notifications/mark-as-read';
  static const String markAllAsRead = '/notifications/mark-all-as-read';

  // Analytics
  static const String analytics = '/analytics';
  static const String trackEvent = '/analytics/track';
}
