# Design System Büyütme Rehberi

Bu döküman, design sistemini nasıl ölçeklendireceğinizi ve genişleteceğinizi açıklar.

## Temel Prensipler

### 1. Token-First Yaklaşım
Design token'ları (renk, spacing, typography) her zaman foundation katmanında tanımlanır. Widget'lar bu token'ları kullanır, hiçbir zaman hard-coded değerler içermez.

**✅ Doğru:**
```dart
// Statik (her ekranda aynı)
Container(
  padding: EdgeInsets.all(AppSpacing.paddingMD),
  color: AppColors.primary,
)

// Responsive (ekrana göre scale olur)
Container(
  padding: EdgeInsets.all(AppSpacingResponsive.paddingMD),
  color: AppColors.primary,
)
```

**❌ Yanlış:**
```dart
Container(
  padding: EdgeInsets.all(16), // Hard-coded
  color: Color(0xFF6366F1), // Hard-coded
)
```

### Statik vs Responsive Token'lar

Her token'ın iki versiyonu var:

- **Statik** (`AppTypography`, `AppSpacing`): Tüm ekranlarda aynı değer
- **Responsive** (`AppTypographyResponsive`, `AppSpacingResponsive`): Ekran boyutuna göre scale olur

**Ne zaman hangisini kullanmalısın?**

Responsive kullan:
- Kullanıcı tarafından okunan text'ler
- Button, card gibi UI elemanları
- Padding, margin, gap değerleri

Statik kullan:
- Logo, icon (fixed size olmalı)
- Splash screen grafikleri
- Decorative elemanlar

### 2. Katmanlı Mimari

```
Foundation Layer (Token'lar)
    ↓
Theme Layer (Tema konfigürasyonu)
    ↓
Component Layer (Widget'lar)
```

Her katman bir alttaki katmana bağımlıdır, yukarıdakine asla.

## Yeni Token Ekleme

### Renk Ekleme
`app_colors.dart` dosyasına yeni renk kategorisi ekleyin:

```dart
// Custom brand colors için
static const Color brandAccent = Color(0xFF..);
static const Color brandAccentLight = Color(0xFF..);
static const Color brandAccentDark = Color(0xFF..);
```

**Kurallar:**
- Her renk için light/dark varyant ekleyin
- Semantic renkleri (success, error, warning, info) override etmeyin
- Yeni kategori ekliyorsanız comment ile gruplayın

### Spacing Ekleme
`app_spacing.dart` dosyasına yeni değer ekleyin:

```dart
// Özel kullanımlar için
static const double customSize = baseUnit * N; // N katları ile
```

**Kurallar:**
- Her değer `baseUnit` (4px) katı olmalı
- Anlamsız sayılar kullanmayın (örn: `baseUnit * 2.5` yerine `baseUnit * 3`)

### Typography Ekleme
`app_typography.dart` dosyasına yeni stil ekleyin:

```dart
static const TextStyle customStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: ..,
  fontWeight: ..,
  height: ..,
  letterSpacing: ..,
  color: AppColors.textPrimary,
);
```

Responsive versiyonu `app_typography_responsive.dart` otomatik oluşturulur, ayrıca bir şey yapman gerekmiyor.

**Kurallar:**
- Material Design 3 type scale'i takip et
- Font family her zaman `AppTypography.fontFamily` kullan
- Renk için `AppColors` token'larını kullan

## Yeni Widget Ekleme

### 1. Widget Dosyası Oluşturma
`lib/src/widgets/` altında yeni dosya:

```dart
// app_widget_name.dart
import 'package:flutter/material.dart';
import 'package:design_system/src/foundation/app_colors.dart';
import 'package:design_system/src/foundation/app_spacing_responsive.dart';
import 'package:design_system/src/foundation/app_typography_responsive.dart';

/// Widget description with usage examples
class AppWidgetName extends StatelessWidget {
  const AppWidgetName({
    super.key,
    // required params
    // optional params with defaults
  });

  @override
  Widget build(BuildContext context) {
    // Genelde responsive token'ları kullan
    return Container(
      padding: EdgeInsets.all(AppSpacingResponsive.paddingMD),
      child: Text(
        'Example',
        style: AppTypographyResponsive.bodyMedium,
      ),
    );
  }
}
```

### 2. Barrel Export'a Ekleme
`lib/design_system.dart` dosyasına export ekleyin:

```dart
export 'src/widgets/app_widget_name.dart';
```

### Widget Kuralları
- **Composition over configuration**: Karmaşık widget'lar yerine küçük, birleştirilebilir widget'lar
- **Theme-aware**: `Theme.of(context)` kullanarak tema bilgisine erişin
- **Token-only**: Hard-coded değer kullanma
- **Responsive by default**: Genelde `AppTypographyResponsive` ve `AppSpacingResponsive` kullan
- **Nullable defaults**: Opsiyonel parametrelere sensible default'lar ver
- **Documentation**: Widget'ın ne yaptığını ve nasıl kullanılacağını açıkla

## Theme Genişletme

### Yeni Component Theme Ekleme
`app_theme.dart` içinde yeni component theme:

```dart
static final WidgetThemeData _widgetTheme = WidgetThemeData(
  // Widget-specific theme using tokens
);

// ThemeData içinde
widgetTheme: _widgetTheme,
```

### Dark Theme Override
Dark theme için farklı değerler gerekiyorsa:

```dart
// light theme
widgetTheme: _widgetTheme,

// dark theme
widgetTheme: _widgetTheme.copyWith(
  property: darkModeValue,
),
```

## Responsive Helper Kullanımı

Bazen custom değerler kullanman gerekebilir. Context extension'ları işini kolaylaştırır:

```dart
class CustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Width-based scaling (font size, padding, horizontal spacing)
      padding: EdgeInsets.all(context.w(20)),
      child: Text(
        'Custom text',
        style: TextStyle(
          fontSize: context.sp(18),  // veya context.w(18)
          height: 1.5,
        ),
      ),
    );
  }
}
```

Helper'lar:
- `context.w(value)` - Width bazlı (font size, padding, horizontal)
- `context.h(value)` - Height bazlı (vertical spacing)
- `context.r(value)` - Radius/circular (icon, border radius)
- `context.sp(value)` - Font size için (w ile aynı)

## Büyütme Stratejisi

### Aşama 1: Foundation Genişletme
1. Eksik renk paletlerini ekle (tertiary, accent, etc.)
2. Animation duration/curve token'ları ekle
3. Elevation/shadow sistem ekle

### Aşama 2: Component Library
1. Form widget'ları (checkbox, radio, switch, dropdown)
2. Feedback widget'ları (snackbar, dialog, bottom sheet)
3. Navigation widget'ları (tab bar, nav bar, drawer)
4. Data display widget'ları (list, table, chart)

### Aşama 3: Layout System
1. Responsive grid system
2. Container/Section wrapper'lar
3. Spacing helper widget'lar (Spacer, Divider varyantları)

### Aşama 4: Advanced Features
1. Theme extension system (custom theme properties)
2. Component variants system (size, style varyantları)
3. Accessibility helpers (a11y token'ları)
4. Motion/Animation sistem

## Versiyonlama

### Breaking Changes
Foundation'da değişiklik yaparken dikkatli olun:
- Token silme → Breaking change
- Token rename → Breaking change
- Token değer değiştirme → Görsel breaking change

### Non-breaking Changes
- Yeni token ekleme → Safe
- Yeni widget ekleme → Safe
- Widget'a yeni optional parametre → Safe

## Checklist: Yeni Özellik Eklerken

- [ ] Token'lar foundation layer'a eklendi mi?
- [ ] Hard-coded değer kullanılmadı mı?
- [ ] Responsive token'lar kullanıldı mı? (UI widget'lar için)
- [ ] Theme konfigürasyonu güncellendi mi?
- [ ] Barrel export dosyasına eklendi mi?
- [ ] README.md güncellendi mi?
- [ ] Hem light hem dark theme test edildi mi?
- [ ] Farklı ekran boyutlarında test edildi mi?
- [ ] Documentation comment eklendi mi?

## Best Practices

1. **Tutarlılık**: Mevcut pattern'leri takip et
2. **Responsive-first**: Genelde responsive token'ları kullan, statik sadece gerektiğinde
3. **Basitlik**: Aşırı karmaşık API'ler yazma
4. **Yeniden kullanılabilirlik**: Spesifik iş lojiği değil, genel UI bileşenleri
5. **Dokümantasyon**: Her public API için örnek ve açıklama
6. **Test edilebilirlik**: Widget'lar bağımsız test edilebilmeli

## Sık Sorulan Sorular

**S: Her zaman responsive kullanmalı mıyım?**
C: Çoğu durumda evet. Logo, splash screen gibi fixed size olması gereken yerler hariç.

**S: Mevcut kodları nasıl güncellerim?**
C: Find & Replace ile `AppTypography.` → `AppTypographyResponsive.` ve `AppSpacing.` → `AppSpacingResponsive.` değiştir. Fixed size olması gereken yerleri geri al.

**S: Custom değerler için ne yapmalıyım?**
C: `context.sp(18)`, `context.w(20)` gibi helper'ları kullan.

**S: Tablet ve telefon için farklı layout yapmak istiyorum?**
C: `context.isTablet` veya `context.isPhone` kontrol et, ona göre farklı widget'lar göster.
