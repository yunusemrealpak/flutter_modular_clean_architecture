# 🚀 Development Scripts Guide

Flutter Modular Clean Architecture projesi için geliştirme araçları ve kod üretici script'ler.

## 📋 Hızlı Başlangıç

Ana geliştirme CLI'ı çalıştırın:

```bash
./dev
```

Menüden istediğiniz işlemi seçin:
- **1**: Yeni Paket Oluştur (Feature/Shared/Infrastructure)
- **2**: Mevcut Pakete BLoC Ekle
- **3**: App Shell Oluştur (Bottom Navigation)
- **4**: Paketleri Listele
- **5**: Yardım
- **0**: Çıkış

## 📁 Script Yapısı

```
project_root/
├── dev                                 # Ana CLI wrapper
├── scripts/
│   ├── cli.sh                         # Ana menü ve orchestrator
│   ├── common/
│   │   └── functions.sh               # Ortak fonksiyonlar ve utilities
│   ├── generators/
│   │   ├── create_package.sh          # Yeni paket oluşturma
│   │   └── create_bloc.sh             # BLoC ekleme
│   ├── utils/
│   │   └── list_packages.sh           # Paket listesi
│   └── README.md                      # Detaylı dokümantasyon
```

## 🎯 Kullanım Örnekleri

### 1️⃣ Yeni Feature Paketi Oluşturma

```bash
./dev
# Menü: 1 (Yeni Paket Oluştur)
# Tür: 1 (Feature)
# İsim: vehicle_acceptance
# Onay: y
```

**Oluşturulan yapı:**
```
packages/features/vehicle_acceptance/
├── lib/
│   ├── vehicle_acceptance.dart
│   └── src/
│       ├── core/                      # DI, Routing, Errors
│       └── feature/
│           ├── data/                  # Models, DataSources, Repositories
│           ├── domain/                # Entities, UseCases
│           └── presentation/          # BLoC, Pages
```

**İçerikler:**
- ✅ Clean Architecture katmanları
- ✅ Freezed models
- ✅ Injectable DI
- ✅ AutoRoute setup
- ✅ Örnek UseCase, Entity, Repository
- ✅ BLoC ile örnek sayfa
- ✅ Network ve Storage entegrasyonu

### 2️⃣ Mevcut Pakete BLoC Ekleme

```bash
./dev
# Menü: 2 (BLoC Ekle)
# Paket: 5 (listeden seç)
# BLoC: vehicle_inspection
# Onay: y
```

**Oluşturulan dosyalar:**
```
packages/features/vehicle_acceptance/lib/src/feature/presentation/bloc/
├── vehicle_inspection_bloc.dart
├── vehicle_inspection_event.dart
└── vehicle_inspection_state.dart
```

**BLoC özellikleri:**
- ✅ Freezed immutable events/states
- ✅ Injectable DI (`@lazySingleton`)
- ✅ Örnek event'ler: Load, Refresh, Delete
- ✅ Örnek state'ler: Initial, Loading, Loaded, Error, DeleteSuccess
- ✅ TODO yorumları ile rehber

### 3️⃣ App Shell Oluşturma (Bottom Navigation)

```bash
./dev
# Menü: 3 (App Shell Oluştur)
# Tab sayısı: 3
# Tab 1: home, Ana Sayfa, home
# Tab 2: search, Ara, search
# Tab 3: profile, Profil, person
# Onay: y
```

**Oluşturulan yapı:**
```
packages/features/app_shell/
├── lib/
│   ├── app_shell.dart
│   └── src/
│       ├── core/
│       │   ├── di/injection.dart
│       │   └── router/
│       │       ├── app_shell_router.dart
│       │       ├── app_shell_routes.dart
│       │       └── tab_routers.dart
│       └── presentation/
│           ├── bloc/
│           │   ├── app_bloc.dart
│           │   ├── app_event.dart
│           │   └── app_state.dart
│           └── pages/
│               └── app_page.dart
```

**İçerikler:**
- ✅ Bottom Navigation ile tab yapısı
- ✅ AutoTabsRouter entegrasyonu
- ✅ BLoC ile tab state management
- ✅ EventBus ile cross-feature navigation
- ✅ Kullanıcı tarafından belirlenen tab sayısı ve isimleri
- ✅ Root projeye entegrasyon talimatları

### 4️⃣ Paketleri Listeleme

```bash
./dev
# Menü: 4 (Paketleri Listele)
```

**Çıktı:**
```
No.   Type            Package Name
──────────────────────────────────────────────────
1     [feature]       auth
2     [feature]       home
3     [feature]       profile
4     [feature]       app_shell
5     [infrastructure] network
6     [infrastructure] event_bus
7     [infrastructure] storage
8     [shared]        config
9     [shared]        design_system
10    [shared]        core
```

## 🔧 Code Generation

Her oluşturma işleminden sonra mutlaka code generation çalıştırın:

```bash
# Tüm proje için
melos run codegen

# Veya belirli bir paket için
cd packages/features/vehicle_acceptance
dart run build_runner build --delete-conflicting-outputs
```

## 📚 Detaylı Dokümantasyon

Daha fazla bilgi için script dokümantasyonuna bakın:

```bash
cat scripts/README.md
```

## 🛠️ Script Geliştirme

### Yeni Script Ekleme

1. İlgili klasöre ekle (`generators/` veya `utils/`)
2. Ortak fonksiyonları kullan:
   ```bash
   source "$SCRIPT_DIR/../common/functions.sh"
   ```
3. Ana menüye ekle (`scripts/cli.sh`)
4. Executable yap: `chmod +x scripts/xxx/new_script.sh`

### Ortak Fonksiyonlar

`scripts/common/functions.sh` içerisinde:

**Print Fonksiyonları:**
- `print_success()` - ✓ Yeşil
- `print_error()` - ✗ Kırmızı
- `print_warning()` - ⚠ Sarı
- `print_info()` - ℹ Mavi
- `print_step()` - [*] Cyan
- `print_header()` - Çerçeveli başlık

**Utility Fonksiyonları:**
- `to_pascal_case()` - snake_case → PascalCase
- `validate_package_name()` - Paket adı validasyonu
- `package_exists()` - Paket varlık kontrolü
- `get_project_root()` - Proje root dizini
- `confirm_action()` - Kullanıcı onayı

## 🐛 Sorun Giderme

### Script çalışmıyor

```bash
# Executable yapın
chmod +x dev

# Line ending düzeltin (Windows'ta)
sed -i 's/\r$//' dev
```

### Path hataları

Script'ler relative path kullanır. Proje root'tan çalıştırın:

```bash
./dev        # ✓ Doğru
cd scripts && ./cli.sh  # ✗ Yanlış
```

### Syntax hataları

Tüm script'leri test edin:

```bash
bash -n dev
bash -n scripts/cli.sh
bash -n scripts/generators/*.sh
bash -n scripts/utils/*.sh
```

## 🎨 Genişletilebilir Yapı

Gelecekte eklenebilecek script kategorileri:

```
scripts/
├── cli.sh
├── common/
├── generators/          # Kod üretimi
│   ├── create_package.sh
│   ├── create_bloc.sh
│   ├── create_usecase.sh      # 🔜 Planlı
│   └── create_repository.sh   # 🔜 Planlı
├── utils/               # Yardımcı araçlar
│   ├── list_packages.sh
│   ├── analyze_code.sh        # 🔜 Planlı
│   └── clean_build.sh         # 🔜 Planlı
├── testing/             # 🔜 Test script'leri
│   ├── run_tests.sh
│   └── generate_coverage.sh
└── deployment/          # 🔜 Deployment script'leri
    ├── build_release.sh
    └── publish.sh
```

## 📄 Lisans

Bu script'ler projenin bir parçasıdır ve aynı lisans altındadır.

---

**Geliştirici:** Flutter Modular Clean Architecture Team
**Güncellenme:** 2025
