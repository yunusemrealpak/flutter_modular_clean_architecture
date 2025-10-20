import 'package:injectable/injectable.dart';
import 'package:storage/storage.dart';

import '../models/auth_token_model.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveAuthToken(AuthTokenModel token);
  Future<AuthTokenModel?> getAuthToken();
  Future<void> removeAuthToken();
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> removeUser();
  Future<bool> isAuthenticated();
  Future<void> clearAuthData();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  late final StorageHelper<AuthTokenDbModel> _storage;

  AuthLocalDataSourceImpl(this._storage);

  @override
  Future<void> saveAuthToken(AuthTokenModel token) async {
    final dbModel = AuthTokenDbModel(
      accessToken: token.data.accessToken,
      issuedAt: token.data.issuedAt,
      expiresIn: token.data.expiresIn,
      refreshToken: token.data.refreshToken,
    );
    await _storage.save(dbModel);
  }

  @override
  Future<AuthTokenModel?> getAuthToken() async {
    final tokenList = await _storage.findAll();
    if (tokenList.isEmpty) return null;

    final dbModel = tokenList.first;

    // Here we would normally reconstruct the full AuthTokenModel from the dbModel
    // but since we only store token and expiryDate, we'll return null for other fields.
    return AuthTokenModel(
      AuthTokenModelData(
        accessToken: dbModel.accessToken,
        refreshToken: dbModel.refreshToken,
        tokenType: '',
        issuedAt: dbModel.issuedAt,
        expiresIn: dbModel.expiresIn,
      ),
    );
  }

  @override
  Future<void> removeAuthToken() async {
    // TODO: Implement actual storage removal
    // Example: await secureStorage.delete('auth_token');
  }

  @override
  Future<void> saveUser(UserModel user) async {}

  @override
  Future<UserModel?> getUser() async {
    return null;
  }

  @override
  Future<void> removeUser() async {}

  @override
  Future<bool> isAuthenticated() async {
    final token = await getAuthToken();
    if (token == null) return false;

    // Check if token is expired
    final entity = token.toEntity();
    return !entity.isExpired;
  }

  @override
  Future<void> clearAuthData() async {
    await removeAuthToken();
    await removeUser();
  }
}
