# Config Package Testing Guide

Bu dokümantasyon, config paketinin testlerini çalıştırmak için gerekli adımları açıklar.

## Ön Gereksinimler

### 1. Environment Dosyalarını Oluşturma

Test edilmek üzere `.env.dev` ve `.env.prod` dosyalarını oluşturun:

```bash
cd packages/shared/config

# Development environment
cat > .env.dev << 'EOF'
API_BASE_URL=https://dev-api.example.com
API_KEY=dev_test_key_12345
API_TIMEOUT=30
APP_NAME=MyApp Dev
APP_VERSION=1.0.0
ENABLE_LOGGING=true
ENABLE_ANALYTICS=false
EOF

# Production environment
cat > .env.prod << 'EOF'
API_BASE_URL=https://api.example.com
API_KEY=prod_test_key_12345
API_TIMEOUT=30
APP_NAME=MyApp
APP_VERSION=1.0.0
ENABLE_LOGGING=false
ENABLE_ANALYTICS=true
EOF
```

### 2. Dependencies Yükleme

```bash
flutter pub get
```

### 3. Code Generation

```bash
# Her iki environment için de kod generate edin
dart run build_runner build --delete-conflicting-outputs
```

Bu komut `lib/src/env/app_env.g.dart` dosyasını oluşturacak.

## Testleri Çalıştırma

### Tüm Testleri Çalıştırma

```bash
flutter test
```

### Belirli Test Dosyasını Çalıştırma

```bash
# Constants testleri
flutter test test/src/constants/app_constants_test.dart

# API Endpoints testleri
flutter test test/src/constants/api_endpoints_test.dart

# Environment testleri (documentation tests)
flutter test test/src/env/app_env_test.dart
```

### Verbose Mode ile Çalıştırma

```bash
flutter test --reporter expanded
```

### Coverage ile Çalıştırma

```bash
flutter test --coverage
```

## Test Yapısı

```
test/
├── config_test.dart                  # Ana test suite
└── src/
    ├── env/
    │   └── app_env_test.dart        # Environment documentation tests
    ├── constants/
    │   ├── app_constants_test.dart  # App constants tests
    │   └── api_endpoints_test.dart  # API endpoints tests
```

## Test Kategorileri

### 1. Environment Tests (`app_env_test.dart`)

AppEnv generated code olduğu için, bu testler documentation ve guideline testleridir:
- Required environment variables
- Field types mapping
- Obfuscation rules
- Naming conventions
- Usage examples
- Best practices

### 2. Constants Tests (`app_constants_test.dart`)

App-wide sabitleri test eder:
- ✅ API configuration
- ✅ Storage keys
- ✅ Pagination settings
- ✅ Timeout durations
- ✅ Cache configuration
- ✅ Validation rules
- ✅ File upload limits
- ✅ Date formats
- ✅ Regular expressions (email, phone, URL)

### 3. API Endpoints Tests (`api_endpoints_test.dart`)

API endpoint tanımlarını test eder:
- ✅ Authentication endpoints
- ✅ User endpoints
- ✅ Posts & Comments endpoints
- ✅ Settings endpoints
- ✅ Notifications endpoints
- ✅ Analytics endpoints
- ✅ Dynamic endpoint generation

## Troubleshooting

### Generated File Not Found

```bash
Error: The file 'app_env.g.dart' doesn't exist.
```

**Solution**: Code generation çalıştırın
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Environment Variables Not Loaded

```bash
Error: The getter 'apiBaseUrl' isn't defined
```

**Solution**: `.env.dev` ve `.env.prod` dosyalarını oluşturun ve code generation çalıştırın

### Type Mismatch Errors

```bash
Error: A value of type 'String' can't be assigned to a variable of type 'int'
```

**Solution**: `.env` dosyalarında değerleri doğru formatta girin:
- String: `API_BASE_URL=https://api.example.com`
- int: `API_TIMEOUT=30` (quotes olmadan)
- bool: `ENABLE_LOGGING=true` (quotes olmadan)

### Obfuscation Not Working

**Problem**: API key obfuscate edilmiyor

**Solution**: AppEnv sınıfında field'ın `final` olduğundan emin olun:
```dart
@EnviedField(varName: 'API_KEY', obfuscate: true)
final String apiKey = _instance.apiKey; // ✅ DOĞRU
```

## CI/CD Integration

### GitHub Actions Example

```yaml
name: Config Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2

      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'

      - name: Create test environment files
        run: |
          cd packages/shared/config
          echo "API_BASE_URL=https://test-api.example.com" > .env.dev
          echo "API_KEY=test_key_12345" >> .env.dev
          echo "API_TIMEOUT=30" >> .env.dev
          echo "APP_NAME=Test App" >> .env.dev
          echo "APP_VERSION=1.0.0" >> .env.dev
          echo "ENABLE_LOGGING=true" >> .env.dev
          echo "ENABLE_ANALYTICS=false" >> .env.dev

          cp .env.dev .env.prod

      - name: Install dependencies
        run: |
          cd packages/shared/config
          flutter pub get

      - name: Generate code
        run: |
          cd packages/shared/config
          dart run build_runner build --delete-conflicting-outputs

      - name: Run tests
        run: |
          cd packages/shared/config
          flutter test --coverage

      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          files: packages/shared/config/coverage/lcov.info
```

## Best Practices

1. **Always run code generation before tests**
   ```bash
   dart run build_runner build --delete-conflicting-outputs && flutter test
   ```

2. **Keep .env files in sync**
   - Ensure all environments have the same variables
   - Use different values but same structure

3. **Never commit .env files**
   - Already in `.gitignore`
   - Use `.env.*.example` as templates

4. **Test coverage**
   - Aim for >80% coverage on non-generated code
   - Document generated code behavior in tests

5. **Regular expression testing**
   - Add more test cases for edge cases
   - Test both valid and invalid inputs

## Expected Test Results

When all tests pass, you should see:

```
00:02 +30: All tests passed!
```

Breakdown:
- Environment Tests: ~7 tests (documentation)
- Constants Tests: ~12 tests
- API Endpoints Tests: ~11 tests

Total: ~30 tests
