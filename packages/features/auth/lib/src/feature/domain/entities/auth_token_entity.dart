import 'package:equatable/equatable.dart';

/// Authentication token entity
class AuthTokenEntity extends Equatable {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;
  final DateTime issuedAt;

  const AuthTokenEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
    required this.issuedAt,
  });

  /// Check if access token is expired
  bool get isExpired {
    final expiryDate = issuedAt.add(Duration(seconds: expiresIn));
    return DateTime.now().isAfter(expiryDate);
  }

  /// Get expiry date
  DateTime get expiryDate => issuedAt.add(Duration(seconds: expiresIn));

  @override
  List<Object?> get props => [
        accessToken,
        refreshToken,
        tokenType,
        expiresIn,
        issuedAt,
      ];

  @override
  String toString() {
    return 'AuthTokenEntity(tokenType: $tokenType, expiresIn: $expiresIn, isExpired: $isExpired)';
  }
}
