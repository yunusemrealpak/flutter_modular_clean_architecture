import 'package:assets/assets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Assets', () {
    test('can be instantiated', () {
      expect(() => Assets.images, returnsNormally);
    });
  });
}
