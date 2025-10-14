# Network Package

Profesyonel Flutter projeleri için kapsamlı bir network paketi. Dio HTTP client, interceptor'lar, hata yönetimi, bağlantı kontrolü ve daha fazlasını içerir.

## Özellikler

- ✅ **HTTP Client**: Dio tabanlı güçlü ve esnek HTTP client
- ✅ **Interceptor'lar**: Auth, Retry, Error Handling, Connectivity kontrolü
- ✅ **Hata Yönetimi**: Özelleştirilmiş exception sınıfları ve otomatik hata dönüşümü
- ✅ **Bağlantı Kontrolü**: İstek öncesi internet bağlantısı kontrolü
- ✅ **Token Yönetimi**: Otomatik token ekleme ve yenileme
- ✅ **Retry Mekanizması**: Başarısız istekleri otomatik yeniden deneme
- ✅ **Loglama**: Detaylı request/response loglama
- ✅ **Dosya Yükleme/İndirme**: Multipart form-data ve file download desteği
- ✅ **Generic Response Models**: API response ve paginated response wrapper'ları

## Kurulum

Paket zaten modüler yapınızın bir parçası olduğundan, doğrudan kullanabilirsiniz:

```dart
import 'package:network/network.dart';
```

## Kullanım

### 1. Temel Kurulum

```dart
// Network info oluştur
final networkInfo = NetworkInfoImpl();

// HTTP client config oluştur
final config = HttpClientConfig(
  baseUrl: 'https://api.example.com',
  connectTimeout: Duration(seconds: 30),
  receiveTimeout: Duration(seconds: 30),
  enableLogging: true,
  enableRetry: true,
  maxRetries: 3,
  enableConnectivityCheck: true,
);

// HTTP client oluştur
final httpClient = HttpClient(
  config: config,
  networkInfo: networkInfo,
);
```

### 2. Authentication Kullanımı

```dart
// Token yönetimi için callback'leri tanımla
httpClient.addAuthInterceptor(
  getAccessToken: () async {
    // Token'ı secure storage'dan al
    return await secureStorage.read(key: 'access_token');
  },
  onTokenRefresh: () async {
    // Token'ı yenile
    final refreshToken = await secureStorage.read(key: 'refresh_token');
    final response = await refreshTokenAPI(refreshToken);
    await secureStorage.write(key: 'access_token', value: response.accessToken);
    return response.accessToken;
  },
  onTokenRefreshFailed: () async {
    // Token yenileme başarısız, kullanıcıyı çıkış yap
    await logout();
  },
);
```

### 3. HTTP İstekleri

#### GET İsteği

```dart
try {
  final response = await httpClient.get<Map<String, dynamic>>(
    '/users',
    queryParameters: {'page': 1, 'limit': 10},
  );

  print('Success: ${response.data}');
} on NetworkException catch (e) {
  print('Error: ${e.message}');
}
```

#### POST İsteği

```dart
try {
  final response = await httpClient.post<Map<String, dynamic>>(
    '/users',
    data: {
      'name': 'John Doe',
      'email': 'john@example.com',
    },
  );

  print('Created: ${response.data}');
} on UnauthorizedException catch (e) {
  // Özel hata yakalama
  print('Unauthorized: ${e.message}');
} on NetworkException catch (e) {
  print('Error: ${e.message}');
}
```

#### PUT, PATCH, DELETE İstekleri

```dart
// PUT
await httpClient.put('/users/1', data: userData);

// PATCH
await httpClient.patch('/users/1', data: partialData);

// DELETE
await httpClient.delete('/users/1');
```

### 4. Dosya Yükleme

```dart
try {
  // Multipart file oluştur
  final file = await HttpClient.createMultipartFile(
    '/path/to/image.jpg',
    filename: 'profile.jpg',
  );

  // Form data oluştur
  final formData = HttpClient.createFormData({
    'name': 'John Doe',
    'avatar': file,
  });

  // Dosyayı yükle
  final response = await httpClient.upload(
    '/users/profile',
    data: formData,
    onSendProgress: (sent, total) {
      print('Upload progress: ${(sent / total * 100).toStringAsFixed(0)}%');
    },
  );

  print('Upload successful: ${response.data}');
} on NetworkException catch (e) {
  print('Upload failed: ${e.message}');
}
```

### 5. Dosya İndirme

```dart
try {
  await httpClient.download(
    '/files/document.pdf',
    '/local/path/document.pdf',
    onReceiveProgress: (received, total) {
      if (total != -1) {
        print('Download progress: ${(received / total * 100).toStringAsFixed(0)}%');
      }
    },
  );

  print('Download complete');
} on NetworkException catch (e) {
  print('Download failed: ${e.message}');
}
```

### 6. API Response Models

#### ApiResponse Kullanımı

```dart
// Generic API response
final response = await httpClient.get('/users/1');
final apiResponse = ApiResponse<User>.fromJson(
  response.data,
  fromJsonT: (json) => User.fromJson(json),
);

if (apiResponse.success) {
  print('User: ${apiResponse.data}');
} else {
  print('Error: ${apiResponse.message}');
}
```

#### PaginatedResponse Kullanımı

```dart
// Sayfalanmış API response
final response = await httpClient.get('/users', queryParameters: {
  'page': 1,
  'limit': 20,
});

final paginatedResponse = PaginatedResponse<User>.fromJson(
  response.data,
  (json) => User.fromJson(json),
);

print('Items: ${paginatedResponse.items.length}');
print('Current Page: ${paginatedResponse.currentPage}');
print('Total Pages: ${paginatedResponse.totalPages}');
print('Has Next: ${paginatedResponse.hasNextPage}');
```

### 7. Bağlantı Kontrolü

```dart
// Manuel bağlantı kontrolü
final networkInfo = NetworkInfoImpl();

// Bağlantı durumunu kontrol et
final isConnected = await networkInfo.isConnected;
if (isConnected) {
  print('Internet connection available');
}

// Bağlantı tipini kontrol et
final connectivityResult = await networkInfo.connectivityResult;
print('Connection type: $connectivityResult');

// Bağlantı değişikliklerini dinle
networkInfo.onConnectivityChanged.listen((result) {
  print('Connectivity changed: $result');
});
```

### 8. Hata Yönetimi

Paket, tüm HTTP hatalarını özelleştirilmiş exception sınıflarına dönüştürür:

```dart
try {
  await httpClient.get('/endpoint');
} on NoInternetException catch (e) {
  print('İnternet bağlantısı yok');
} on UnauthorizedException catch (e) {
  print('Yetkilendirme hatası: ${e.message}');
  // Kullanıcıyı login sayfasına yönlendir
} on NotFoundException catch (e) {
  print('Kaynak bulunamadı: ${e.message}');
} on TimeoutException catch (e) {
  print('İstek zaman aşımına uğradı');
} on InternalServerException catch (e) {
  print('Sunucu hatası: ${e.message}');
} on NetworkException catch (e) {
  print('Genel hata: ${e.message}');
}
```

### 9. İstek İptali

```dart
// Cancel token oluştur
final cancelToken = CancelToken();

// İsteği gönder
final requestFuture = httpClient.get(
  '/endpoint',
  cancelToken: cancelToken,
);

// İsteği iptal et
cancelToken.cancel('User cancelled the request');

try {
  await requestFuture;
} on CancelException catch (e) {
  print('İstek iptal edildi');
}
```

### 10. Özel Interceptor Ekleme

```dart
// Özel interceptor oluştur
class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Custom logic
    print('Request: ${options.path}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Custom logic
    print('Response: ${response.statusCode}');
    handler.next(response);
  }
}

// Interceptor'ı ekle
httpClient.addInterceptor(CustomInterceptor());
```

## Klasör Yapısı

```
lib/
├── network.dart              # Ana export dosyası
└── src/
    ├── client/              # HTTP client ve konfigürasyon
    │   ├── http_client.dart
    │   └── http_client_config.dart
    ├── interceptors/        # Interceptor sınıfları
    │   ├── auth_interceptor.dart
    │   ├── retry_interceptor.dart
    │   ├── error_interceptor.dart
    │   └── connectivity_interceptor.dart
    ├── exceptions/          # Exception sınıfları
    │   └── network_exception.dart
    ├── models/             # Response model'leri
    │   ├── api_response.dart
    │   └── paginated_response.dart
    ├── connectivity/       # Bağlantı kontrolü
    │   └── network_info.dart
    └── utils/             # Yardımcı sınıflar
        └── network_logger.dart
```

## Exception Tipleri

| Exception | HTTP Status | Açıklama |
|-----------|-------------|----------|
| `NoInternetException` | - | İnternet bağlantısı yok |
| `TimeoutException` | - | İstek zaman aşımına uğradı |
| `BadRequestException` | 400 | Hatalı istek |
| `UnauthorizedException` | 401 | Yetkisiz erişim |
| `ForbiddenException` | 403 | Erişim yasak |
| `NotFoundException` | 404 | Kaynak bulunamadı |
| `ConflictException` | 409 | Çakışma hatası |
| `InternalServerException` | 500 | Sunucu hatası |
| `ServiceUnavailableException` | 503 | Servis kullanılamıyor |
| `CancelException` | - | İstek iptal edildi |
| `ParseException` | - | Response parse hatası |
| `UnknownException` | - | Bilinmeyen hata |

## İleri Seviye Kullanım

### Custom Base Options

```dart
final config = HttpClientConfig(
  baseUrl: 'https://api.example.com',
  headers: {
    'Accept': 'application/json',
    'X-Custom-Header': 'value',
  },
  queryParameters: {
    'api_key': 'your_api_key',
  },
  connectTimeout: Duration(minutes: 1),
  receiveTimeout: Duration(minutes: 1),
  followRedirects: true,
  maxRedirects: 5,
);
```

### Request Options Özelleştirme

```dart
final response = await httpClient.get(
  '/endpoint',
  options: Options(
    headers: {'Custom-Header': 'Value'},
    responseType: ResponseType.json,
    validateStatus: (status) => status! < 500,
  ),
);
```

## En İyi Pratikler

1. **Dependency Injection**: HttpClient'ı dependency injection ile kullanın
2. **Error Handling**: Her zaman spesifik exception'ları yakalayın
3. **Token Management**: Secure storage kullanarak token'ları saklayın
4. **Logging**: Production'da loglama'yı kapatın (`enableLogging: false`)
5. **Timeout**: Uygun timeout değerleri belirleyin
6. **Retry**: Sadece idempotent istekler için retry kullanın (GET, PUT, DELETE)
7. **Cancel Token**: Uzun süren istekler için cancel token kullanın
8. **Connection Check**: Büyük dosya indirme/yükleme öncesi bağlantıyı kontrol edin

## Lisans

Bu paket, modüler clean architecture template'inin bir parçasıdır.
