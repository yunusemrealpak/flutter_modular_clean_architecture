import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late MockConnectivity mockConnectivity;
  late NetworkInfoImpl networkInfo;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfo = NetworkInfoImpl(connectivity: mockConnectivity);
  });

  group('NetworkInfo Tests', () {
    test('isConnected should return true when connected to wifi', () async {
      // Arrange
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.wifi]);

      // Act
      final result = await networkInfo.isConnected;

      // Assert
      expect(result, true);
      verify(() => mockConnectivity.checkConnectivity()).called(1);
    });

    test('isConnected should return true when connected to mobile', () async {
      // Arrange
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.mobile]);

      // Act
      final result = await networkInfo.isConnected;

      // Assert
      expect(result, true);
    });

    test('isConnected should return false when not connected', () async {
      // Arrange
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.none]);

      // Act
      final result = await networkInfo.isConnected;

      // Assert
      expect(result, false);
    });

    test('isConnected should return false when list is empty', () async {
      // Arrange
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => []);

      // Act
      final result = await networkInfo.isConnected;

      // Assert
      expect(result, false);
    });

    test('connectivityResult should return correct result', () async {
      // Arrange
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.wifi]);

      // Act
      final result = await networkInfo.connectivityResult;

      // Assert
      expect(result, [ConnectivityResult.wifi]);
    });

    test('onConnectivityChanged should return connectivity stream', () {
      // Arrange
      final stream = Stream.value([ConnectivityResult.mobile]);
      when(() => mockConnectivity.onConnectivityChanged).thenAnswer((_) => stream);

      // Act
      final result = networkInfo.onConnectivityChanged;

      // Assert
      expect(result, stream);
    });
  });
}
