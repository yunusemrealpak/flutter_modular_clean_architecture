import 'package:flutter_test/flutter_test.dart';
import 'package:config/config.dart';

void main() {
  group('ApiEndpoints Tests', () {
    group('Authentication Endpoints', () {
      test('should have correct authentication endpoints', () {
        expect(ApiEndpoints.login, '/auth/login');
        expect(ApiEndpoints.register, '/auth/register');
        expect(ApiEndpoints.logout, '/auth/logout');
        expect(ApiEndpoints.refreshToken, '/auth/refresh');
        expect(ApiEndpoints.forgotPassword, '/auth/forgot-password');
        expect(ApiEndpoints.resetPassword, '/auth/reset-password');
        expect(ApiEndpoints.verifyEmail, '/auth/verify-email');
      });
    });

    group('User Endpoints', () {
      test('should have correct user endpoints', () {
        expect(ApiEndpoints.profile, '/user/profile');
        expect(ApiEndpoints.updateProfile, '/user/profile');
        expect(ApiEndpoints.changePassword, '/user/change-password');
        expect(ApiEndpoints.deleteAccount, '/user/delete');
        expect(ApiEndpoints.uploadAvatar, '/user/avatar');
      });
    });

    group('Users (Admin) Endpoints', () {
      test('should have correct users endpoints', () {
        expect(ApiEndpoints.users, '/users');
      });

      test('should generate correct user by ID endpoint', () {
        expect(ApiEndpoints.userById('123'), '/users/123');
        expect(ApiEndpoints.userById('abc'), '/users/abc');
      });

      test('should generate correct user posts endpoint', () {
        expect(ApiEndpoints.userPosts('123'), '/users/123/posts');
        expect(ApiEndpoints.userPosts('456'), '/users/456/posts');
      });
    });

    group('Posts Endpoints', () {
      test('should have correct posts endpoints', () {
        expect(ApiEndpoints.posts, '/posts');
      });

      test('should generate correct post by ID endpoint', () {
        expect(ApiEndpoints.postById('1'), '/posts/1');
        expect(ApiEndpoints.postById('abc'), '/posts/abc');
      });

      test('should generate correct post comments endpoint', () {
        expect(ApiEndpoints.postComments('1'), '/posts/1/comments');
        expect(ApiEndpoints.postComments('123'), '/posts/123/comments');
      });
    });

    group('Comments Endpoints', () {
      test('should have correct comments endpoints', () {
        expect(ApiEndpoints.comments, '/comments');
      });

      test('should generate correct comment by ID endpoint', () {
        expect(ApiEndpoints.commentById('1'), '/comments/1');
        expect(ApiEndpoints.commentById('xyz'), '/comments/xyz');
      });
    });

    group('Settings Endpoints', () {
      test('should have correct settings endpoints', () {
        expect(ApiEndpoints.settings, '/settings');
        expect(ApiEndpoints.updateSettings, '/settings');
      });
    });

    group('Notifications Endpoints', () {
      test('should have correct notifications endpoints', () {
        expect(ApiEndpoints.notifications, '/notifications');
        expect(ApiEndpoints.markAsRead, '/notifications/mark-as-read');
        expect(ApiEndpoints.markAllAsRead, '/notifications/mark-all-as-read');
      });

      test('should generate correct notification by ID endpoint', () {
        expect(ApiEndpoints.notificationById('1'), '/notifications/1');
        expect(ApiEndpoints.notificationById('abc'), '/notifications/abc');
      });
    });

    group('Analytics Endpoints', () {
      test('should have correct analytics endpoints', () {
        expect(ApiEndpoints.analytics, '/analytics');
        expect(ApiEndpoints.trackEvent, '/analytics/track');
      });
    });
  });
}
