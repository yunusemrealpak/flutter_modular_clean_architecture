import 'package:core/core.dart';
import 'package:network/network.dart';
import 'package:storage/storage.dart';

@module
abstract class AuthModule {
  @lazySingleton
  HttpClient get httpClient =>
      HttpClient(config: HttpClientConfig(baseUrl: 'http://localhost:3000'));

  @singleton
  NetworkInfo get networkInfo => NetworkInfoImpl();

  @lazySingleton
  StorageHelper<AuthTokenDbModel> get storageHelper =>
      StorageHelper<AuthTokenDbModel>();
}
