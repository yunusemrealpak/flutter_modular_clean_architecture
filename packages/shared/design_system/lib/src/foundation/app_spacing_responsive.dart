import 'package:design_system/src/foundation/app_responsive.dart';
import 'package:design_system/src/foundation/app_spacing.dart';

/// Responsive spacing that scales based on screen size
///
/// Use this instead of AppSpacing for responsive sizes.
/// All values scale based on screen width relative to reference size (390px).
///
/// Example:
/// ```dart
/// SizedBox(height: AppSpacingResponsive.md)
/// Padding(padding: EdgeInsets.all(AppSpacingResponsive.paddingMD))
/// ```
class AppSpacingResponsive {
  AppSpacingResponsive._();

  // Base unit
  static double get baseUnit => AppResponsive.w(AppSpacing.baseUnit);

  // Spacing scale
  static double get xxs => AppResponsive.w(AppSpacing.xxs);
  static double get xs => AppResponsive.w(AppSpacing.xs);
  static double get sm => AppResponsive.w(AppSpacing.sm);
  static double get md => AppResponsive.w(AppSpacing.md);
  static double get lg => AppResponsive.w(AppSpacing.lg);
  static double get xl => AppResponsive.w(AppSpacing.xl);
  static double get xxl => AppResponsive.w(AppSpacing.xxl);
  static double get xxxl => AppResponsive.w(AppSpacing.xxxl);

  // Common padding values
  static double get paddingXS => AppResponsive.w(AppSpacing.paddingXS);
  static double get paddingSM => AppResponsive.w(AppSpacing.paddingSM);
  static double get paddingMD => AppResponsive.w(AppSpacing.paddingMD);
  static double get paddingLG => AppResponsive.w(AppSpacing.paddingLG);
  static double get paddingXL => AppResponsive.w(AppSpacing.paddingXL);

  // Common margin values
  static double get marginXS => AppResponsive.w(AppSpacing.marginXS);
  static double get marginSM => AppResponsive.w(AppSpacing.marginSM);
  static double get marginMD => AppResponsive.w(AppSpacing.marginMD);
  static double get marginLG => AppResponsive.w(AppSpacing.marginLG);
  static double get marginXL => AppResponsive.w(AppSpacing.marginXL);

  // Gap values for Row/Column
  static double get gapXS => AppResponsive.w(AppSpacing.gapXS);
  static double get gapSM => AppResponsive.w(AppSpacing.gapSM);
  static double get gapMD => AppResponsive.w(AppSpacing.gapMD);
  static double get gapLG => AppResponsive.w(AppSpacing.gapLG);

  // Border radius (using r for circular consistency)
  static double get radiusXS => AppResponsive.r(AppSpacing.radiusXS);
  static double get radiusSM => AppResponsive.r(AppSpacing.radiusSM);
  static double get radiusMD => AppResponsive.r(AppSpacing.radiusMD);
  static double get radiusLG => AppResponsive.r(AppSpacing.radiusLG);
  static double get radiusXL => AppResponsive.r(AppSpacing.radiusXL);
  static double get radiusFull => AppSpacing.radiusFull; // Keep full radius as is

  // Icon sizes (using r for consistency)
  static double get iconXS => AppResponsive.r(AppSpacing.iconXS);
  static double get iconSM => AppResponsive.r(AppSpacing.iconSM);
  static double get iconMD => AppResponsive.r(AppSpacing.iconMD);
  static double get iconLG => AppResponsive.r(AppSpacing.iconLG);
  static double get iconXL => AppResponsive.r(AppSpacing.iconXL);
}
