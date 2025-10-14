import 'package:flutter_test/flutter_test.dart';
import 'package:config/config.dart';

void main() {
  group('AppConstants Tests', () {
    test('API configuration constants should have correct values', () {
      expect(AppConstants.apiVersion, 'v1');
      expect(AppConstants.contentType, 'application/json');
      expect(AppConstants.acceptLanguage, 'Accept-Language');
    });

    test('Storage keys should be defined', () {
      expect(AppConstants.accessTokenKey, 'access_token');
      expect(AppConstants.refreshTokenKey, 'refresh_token');
      expect(AppConstants.userIdKey, 'user_id');
      expect(AppConstants.userDataKey, 'user_data');
      expect(AppConstants.themeKey, 'theme_mode');
      expect(AppConstants.languageKey, 'language');
      expect(AppConstants.onboardingKey, 'onboarding_completed');
    });

    test('Pagination constants should have correct values', () {
      expect(AppConstants.defaultPageSize, 20);
      expect(AppConstants.maxPageSize, 100);
    });

    test('Timeout durations should be defined', () {
      expect(AppConstants.defaultTimeout, const Duration(seconds: 30));
      expect(AppConstants.uploadTimeout, const Duration(minutes: 5));
      expect(AppConstants.downloadTimeout, const Duration(minutes: 10));
    });

    test('Cache configuration should be defined', () {
      expect(AppConstants.cacheExpiration, const Duration(hours: 1));
      expect(AppConstants.maxCacheSize, 50 * 1024 * 1024);
    });

    test('Retry configuration should be defined', () {
      expect(AppConstants.maxRetries, 3);
      expect(AppConstants.retryDelay, const Duration(seconds: 1));
    });

    test('Validation constants should have correct values', () {
      expect(AppConstants.minPasswordLength, 8);
      expect(AppConstants.maxPasswordLength, 128);
      expect(AppConstants.minUsernameLength, 3);
      expect(AppConstants.maxUsernameLength, 50);
    });

    test('File upload constants should be defined', () {
      expect(AppConstants.maxFileSize, 10 * 1024 * 1024);
      expect(AppConstants.allowedImageExtensions, [
        'jpg',
        'jpeg',
        'png',
        'gif',
        'webp',
      ]);
      expect(AppConstants.allowedDocumentExtensions, [
        'pdf',
        'doc',
        'docx',
        'txt',
      ]);
    });

    test('Date format constants should be defined', () {
      expect(AppConstants.dateFormat, 'yyyy-MM-dd');
      expect(AppConstants.dateTimeFormat, 'yyyy-MM-dd HH:mm:ss');
      expect(AppConstants.displayDateFormat, 'dd MMM yyyy');
      expect(AppConstants.displayDateTimeFormat, 'dd MMM yyyy, HH:mm');
    });

    group('Regular Expressions', () {
      test('Email regex should validate correct emails', () {
        expect(AppConstants.emailRegex.hasMatch('test@example.com'), true);
        expect(AppConstants.emailRegex.hasMatch('user.name@domain.co.uk'), true);
        expect(AppConstants.emailRegex.hasMatch('invalid@'), false);
        expect(AppConstants.emailRegex.hasMatch('@invalid.com'), false);
        expect(AppConstants.emailRegex.hasMatch('invalid'), false);
      });

      test('Phone regex should validate correct phone numbers', () {
        expect(AppConstants.phoneRegex.hasMatch('+905551234567'), true);
        expect(AppConstants.phoneRegex.hasMatch('905551234567'), true);
        expect(AppConstants.phoneRegex.hasMatch('+1234567890'), true);
        expect(AppConstants.phoneRegex.hasMatch('123'), false);
        expect(AppConstants.phoneRegex.hasMatch('abc'), false);
      });

      test('URL regex should validate correct URLs', () {
        expect(AppConstants.urlRegex.hasMatch('https://example.com'), true);
        expect(AppConstants.urlRegex.hasMatch('http://www.example.com'), true);
        expect(
          AppConstants.urlRegex.hasMatch('https://example.com/path?query=1'),
          true,
        );
        expect(AppConstants.urlRegex.hasMatch('invalid-url'), false);
        expect(AppConstants.urlRegex.hasMatch('ftp://example.com'), false);
      });
    });
  });
}
