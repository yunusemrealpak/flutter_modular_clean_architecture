# Config Package

Profesyonel Flutter projeleri için type-safe environment configuration paketi. `envied` kullanarak güvenli ve obfuscated environment variable yönetimi sağlar.

## Özellikler

- ✅ **Multiple Environments**: Development, Staging, Production desteği
- ✅ **Type-Safe**: Compile-time type checking
- ✅ **Obfuscation**: API key'lerin güvenli saklanması
- ✅ **Auto-Selection**: Build mode veya flavor'a göre otomatik environment seçimi
- ✅ **Constants**: Uygulama çapında sabitler
- ✅ **API Endpoints**: Merkezi endpoint yönetimi
- ✅ **Flexible**: CLI'dan environment değiştirme desteği

## Kurulum

Paket zaten modüler yapınızın bir parçası olduğundan, doğrudan kullanabilirsiniz:

```dart
import 'package:config/config.dart';
```

## Başlangıç

### 1. Environment Dosyalarını Oluşturma

Her environment için `.env` dosyası oluşturun:

```bash
# Development için
cp .env.dev.example .env.dev

# Staging için
cp .env.staging.example .env.staging

# Production için
cp .env.prod.example .env.prod
```

### 2. Environment Değişkenlerini Doldurma

`.env.dev` dosyası örneği:

```env
# API Configuration
API_BASE_URL=https://dev-api.example.com
API_KEY=dev_your_secret_api_key_here
API_TIMEOUT=30

# App Configuration
APP_NAME=MyApp Dev
APP_VERSION=1.0.0

# Feature Flags
ENABLE_LOGGING=true
ENABLE_ANALYTICS=false

# Optional Services
SENTRY_DSN=https://your-sentry-dsn@sentry.io/project-id
FIREBASE_PROJECT_ID=your-firebase-project-dev
ANALYTICS_TRACKING_ID=UA-XXXXXXXXX-X
```

### 3. Code Generation

Environment dosyalarından Dart kodunu generate edin:

```bash
# Development için (varsayılan)
dart run build_runner build --delete-conflicting-outputs

# Staging için
dart run build_runner build --delete-conflicting-outputs --define=envied_generator:envied=path=.env.staging

# Production için
dart run build_runner build --delete-conflicting-outputs --define=envied_generator:envied=path=.env.prod
```

## Kullanım

### 1. Temel Kullanım

```dart
import 'package:config/config.dart';

void main() {
  // Environment instance'ı al
  final env = AppEnv();

  // Environment değişkenlerine eriş
  print('API URL: ${env.apiBaseUrl}');
  print('API Key: ${env.apiKey}'); // Obfuscated
  print('App Name: ${env.appName}');
  print('Logging: ${env.isLoggingEnabled}');

  // Environment bilgisi
  print('Environment: ${AppEnv.environmentName}');
  print('Is Dev: ${AppEnv.isDevelopment}');
  print('Is Production: ${AppEnv.isProduction}');
}
```

### 2. HTTP Client ile Kullanım

```dart
import 'package:config/config.dart';
import 'package:network/network.dart';

void initializeHttpClient() {
  final env = AppEnv();

  final config = HttpClientConfig(
    baseUrl: env.apiBaseUrl,
    connectTimeout: env.apiTimeoutDuration,
    enableLogging: env.isLoggingEnabled,
  );

  final httpClient = HttpClient(
    config: config,
    networkInfo: NetworkInfoImpl(),
  );

  // Auth interceptor ekle
  httpClient.addAuthInterceptor(
    getAccessToken: () async => env.apiKey,
  );
}
```

### 3. Constants Kullanımı

```dart
import 'package:config/config.dart';

// API endpoints
void fetchUsers() async {
  final response = await httpClient.get(ApiEndpoints.users);
}

// User endpoints
void fetchUserById(String userId) async {
  final endpoint = ApiEndpoints.userById(userId);
  final response = await httpClient.get(endpoint);
}

// App constants
void validatePassword(String password) {
  if (password.length < AppConstants.minPasswordLength) {
    throw Exception('Password too short');
  }
}

// Date formatting
void formatDate(DateTime date) {
  final formatter = DateFormat(AppConstants.displayDateFormat);
  print(formatter.format(date));
}
```

### 4. Environment Switching

#### Build Mode ile (Otomatik)

```bash
# Debug mode -> Development environment
flutter run

# Release mode -> Production environment
flutter run --release
```

#### Flavor ile

```bash
# Development
flutter run --dart-define=FLAVOR=dev

# Staging
flutter run --dart-define=FLAVOR=staging

# Production
flutter run --dart-define=FLAVOR=prod
```

### 5. Optional Variables

```dart
// Optional değişkenlere güvenli erişim
final env = AppEnv();

// Sentry kullanıyorsa
if (env.sentryDsn != null) {
  await Sentry.init(
    (options) => options.dsn = env.sentryDsn!,
  );
}

// Firebase kullanıyorsa
if (env.firebaseProjectId != null) {
  await Firebase.initializeApp(
    options: FirebaseOptions(projectId: env.firebaseProjectId!),
  );
}
```

## Klasör Yapısı

```
lib/
├── config.dart                    # Ana export dosyası
└── src/
    ├── env/                       # Environment configuration
    │   ├── app_env.dart           # Ana environment sınıfı
    │   └── env.dart               # Barrel export
    └── constants/                 # Application constants
        ├── app_constants.dart     # Genel sabitler
        ├── api_endpoints.dart     # API endpoint'leri
        └── constants.dart         # Barrel export

# Environment dosyaları (root'ta)
├── .env.dev.example              # Dev environment örneği
├── .env.staging.example          # Staging environment örneği
├── .env.prod.example             # Prod environment örneği
├── .env.dev                      # Dev environment (gitignore'da)
├── .env.staging                  # Staging environment (gitignore'da)
├── .env.prod                     # Prod environment (gitignore'da)
└── build.yaml                    # Build configuration
```

## Environment Variables

### Required Variables

| Variable | Açıklama | Örnek |
|----------|----------|-------|
| `API_BASE_URL` | Backend API base URL | `https://api.example.com` |
| `API_KEY` | API authentication key (obfuscated) | `your_secret_key` |
| `APP_NAME` | Uygulama adı | `MyApp` |

### Optional Variables

| Variable | Açıklama | Default |
|----------|----------|---------|
| `API_TIMEOUT` | API timeout (saniye) | `30` |
| `APP_VERSION` | Uygulama versiyonu | `1.0.0` |
| `ENABLE_LOGGING` | Logging aktif mi? | `false` |
| `ENABLE_ANALYTICS` | Analytics aktif mi? | `false` |
| `SENTRY_DSN` | Sentry DSN | `null` |
| `FIREBASE_PROJECT_ID` | Firebase project ID | `null` |
| `ANALYTICS_TRACKING_ID` | Analytics tracking ID | `null` |

## Best Practices

### 1. Güvenlik

```bash
# ✅ YAPILMASI GEREKENLER

# .env dosyalarını ASLA git'e commit etmeyin
# .gitignore'da zaten tanımlı ama kontrol edin
cat .gitignore | grep .env

# Sensitive değerler için obfuscation kullanın
@EnviedField(obfuscate: true)
static final String apiKey = _Env.apiKey;

# ❌ YAPILMAMASI GEREKENLER

# .env dosyalarını git'e eklemeyin
git add .env  # YAPMAYIN!

# API key'leri const olarak tanımlamayın (obfuscate için)
static const String apiKey = _Env.apiKey;  # YANLIŞ!
```

### 2. Environment Yönetimi

```dart
// ✅ İYİ UYGULAMA
void initializeApp() {
  final env = AppEnv();

  // Environment'a göre farklı davran
  if (AppEnv.isDevelopment) {
    // Development-specific setup
    debugPrint('Running in development mode');
  }

  if (env.isLoggingEnabled) {
    // Setup logging
  }
}

// ❌ KÖTÜ UYGULAMA
void initializeApp() {
  // Hard-coded values
  const apiUrl = 'https://api.example.com'; // YAPMAYIN!
}
```

### 3. Yeni Environment Variable Ekleme

1. `AppEnv` sınıfına field ekleyin:

```dart
@EnviedField(defaultValue: 'default_value')
String get newVariable;
```

2. Tüm `.env` dosyalarına ekleyin:

```env
NEW_VARIABLE=value
```

3. Code generation çalıştırın:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## CI/CD Integration

### GitHub Actions Örneği

```yaml
name: Build

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2

      - name: Create .env.prod
        run: |
          echo "API_BASE_URL=${{ secrets.API_BASE_URL }}" >> .env.prod
          echo "API_KEY=${{ secrets.API_KEY }}" >> .env.prod
          echo "APP_NAME=MyApp" >> .env.prod

      - name: Generate code
        run: |
          dart run build_runner build --delete-conflicting-outputs --define=envied_generator:envied=path=.env.prod

      - name: Build
        run: flutter build apk --release
```

## Troubleshooting

### 1. Generated dosyalar bulunamıyor

```bash
# Solution: Code generation çalıştırın
dart run build_runner build --delete-conflicting-outputs
```

### 2. Environment değişkenleri yüklenmiyor

```bash
# .env dosyasının doğru konumda olduğundan emin olun
ls -la .env.dev

# build.yaml'da path'i kontrol edin
cat build.yaml
```

### 3. Obfuscated değerler çalışmıyor

```dart
// const yerine final kullanın
@EnviedField(obfuscate: true)
static final String apiKey = _Env.apiKey; // ✅ DOĞRU

@EnviedField(obfuscate: true)
static const String apiKey = _Env.apiKey; // ❌ YANLIŞ
```

## Örnek Senaryolar

### Senaryo 1: Yeni Bir Mikro Servis Ekleme

```dart
// 1. api_endpoints.dart'a endpoint ekle
class ApiEndpoints {
  static const String payments = '/payments';
  static String paymentById(String id) => '/payments/$id';
}

// 2. Kullan
final response = await httpClient.get(ApiEndpoints.payments);
```

### Senaryo 2: Feature Flag Ekleme

```dart
// 1. AppEnv'e ekle
@EnviedField(defaultValue: 'false')
String get enableNewFeature;

bool get isNewFeatureEnabled => enableNewFeature.toLowerCase() == 'true';

// 2. .env dosyalarına ekle
ENABLE_NEW_FEATURE=true

// 3. Kullan
if (AppEnv().isNewFeatureEnabled) {
  // Show new feature
}
```

## Lisans

Bu paket, modüler clean architecture template'inin bir parçasıdır.
