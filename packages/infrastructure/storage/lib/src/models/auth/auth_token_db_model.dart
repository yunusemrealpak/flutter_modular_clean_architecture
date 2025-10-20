import 'package:objectbox/objectbox.dart';
import 'package:storage/src/core/base_db_model.dart';

@Entity()
class AuthTokenDbModel implements DbModel {
  @override
  @Id()
  int id = 0;

  String accessToken;
  String refreshToken;
  DateTime issuedAt;
  int expiresIn;

  AuthTokenDbModel({
    required this.accessToken,
    required this.issuedAt,
    required this.expiresIn,
    this.refreshToken = '',
  });

  @override
  int get entityId => id;

  @override
  bool validate() {
    return accessToken.isNotEmpty &&
        issuedAt.add(Duration(seconds: expiresIn)).isAfter(DateTime.now());
  }
}
