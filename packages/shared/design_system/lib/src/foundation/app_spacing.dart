/// App spacing system based on 4px base unit
///
/// Provides consistent spacing throughout the app.
/// All values are multiples of 4 for better alignment.
class AppSpacing {
  AppSpacing._();

  // Base unit: 4px
  static const double baseUnit = 4.0;

  // Spacing scale
  static const double xxs = baseUnit; // 4px
  static const double xs = baseUnit * 2; // 8px
  static const double sm = baseUnit * 3; // 12px
  static const double md = baseUnit * 4; // 16px
  static const double lg = baseUnit * 6; // 24px
  static const double xl = baseUnit * 8; // 32px
  static const double xxl = baseUnit * 12; // 48px
  static const double xxxl = baseUnit * 16; // 64px

  // Common padding values
  static const double paddingXS = xs; // 8px
  static const double paddingSM = sm; // 12px
  static const double paddingMD = md; // 16px
  static const double paddingLG = lg; // 24px
  static const double paddingXL = xl; // 32px

  // Common margin values
  static const double marginXS = xs; // 8px
  static const double marginSM = sm; // 12px
  static const double marginMD = md; // 16px
  static const double marginLG = lg; // 24px
  static const double marginXL = xl; // 32px

  // Gap values for Row/Column
  static const double gapXS = xs; // 8px
  static const double gapSM = sm; // 12px
  static const double gapMD = md; // 16px
  static const double gapLG = lg; // 24px

  // Border radius
  static const double radiusXS = xxs; // 4px
  static const double radiusSM = xs; // 8px
  static const double radiusMD = sm; // 12px
  static const double radiusLG = md; // 16px
  static const double radiusXL = lg; // 24px
  static const double radiusFull = 9999; // Full radius (pill shape)

  // Icon sizes
  static const double iconXS = md; // 16px
  static const double iconSM = lg - baseUnit; // 20px
  static const double iconMD = lg; // 24px
  static const double iconLG = xl; // 32px
  static const double iconXL = xxl; // 48px
}
