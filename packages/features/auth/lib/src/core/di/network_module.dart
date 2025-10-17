import 'package:injectable/injectable.dart';
import 'package:network/network.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  HttpClient get httpClient =>
      HttpClient(config: HttpClientConfig(baseUrl: 'http://localhost:3000'));

  @singleton
  NetworkInfo get networkInfo => NetworkInfoImpl();
}
