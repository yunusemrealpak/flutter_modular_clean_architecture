import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Responsive sizing system for consistent UI across different screen sizes
///
/// Problem: Fixed font sizes (e.g., 16px) appear different on various screen sizes.
/// On smaller screens, 16px takes more percentage of screen, appearing larger.
/// On larger screens (tablets), same 16px appears smaller.
///
/// Solution: Scale sizes based on screen width to maintain visual consistency.
class AppResponsive {
  AppResponsive._();

  /// Reference screen width (iPhone 13 Pro / Pixel 5 width)
  /// Design should be based on this width
  static const double referenceWidth = 390.0;

  /// Reference screen height
  static const double referenceHeight = 844.0;

  /// Minimum scale factor to prevent text from becoming too small
  static const double minScale = 0.85;

  /// Maximum scale factor to prevent text from becoming too large
  static const double maxScale = 1.15;

  /// Get current screen width
  static double get screenWidth {
    return ui.PlatformDispatcher.instance.views.first.physicalSize.width /
        ui.PlatformDispatcher.instance.views.first.devicePixelRatio;
  }

  /// Get current screen height
  static double get screenHeight {
    return ui.PlatformDispatcher.instance.views.first.physicalSize.height /
        ui.PlatformDispatcher.instance.views.first.devicePixelRatio;
  }

  /// Calculate width scale factor based on current screen
  static double getWidthScale() {
    final scale = screenWidth / referenceWidth;
    return scale.clamp(minScale, maxScale);
  }

  /// Calculate height scale factor based on current screen
  static double getHeightScale() {
    final scale = screenHeight / referenceHeight;
    return scale.clamp(minScale, maxScale);
  }

  /// Scale a value based on screen width
  ///
  /// Use this for font sizes, padding, margin, etc.
  ///
  /// Example:
  /// ```dart
  /// fontSize: AppResponsive.w(16) // Scales 16 based on screen width
  /// ```
  static double w(double size) {
    return size * getWidthScale();
  }

  /// Scale a value based on screen height
  ///
  /// Use this for vertical spacing, heights, etc.
  ///
  /// Example:
  /// ```dart
  /// height: AppResponsive.h(100)
  /// ```
  static double h(double size) {
    return size * getHeightScale();
  }

  /// Scale a value based on smaller dimension (width or height)
  ///
  /// Useful for sizes that should be consistent regardless of orientation
  ///
  /// Example:
  /// ```dart
  /// iconSize: AppResponsive.r(24)
  /// ```
  static double r(double size) {
    final widthScale = getWidthScale();
    final heightScale = getHeightScale();
    final scale = widthScale < heightScale ? widthScale : heightScale;
    return size * scale;
  }

  /// Get responsive font size (alias for w)
  static double sp(double fontSize) => w(fontSize);

  /// Check if current device is a tablet (width > 600)
  static bool get isTablet => screenWidth > 600;

  /// Check if current device is a phone
  static bool get isPhone => !isTablet;

  /// Check if screen is small (width < 360)
  static bool get isSmallScreen => screenWidth < 360;

  /// Check if screen is large (width > 600)
  static bool get isLargeScreen => screenWidth > 600;
}

/// Extension on BuildContext for easier access to responsive values
extension ResponsiveContext on BuildContext {
  /// Get responsive width
  double w(double size) => AppResponsive.w(size);

  /// Get responsive height
  double h(double size) => AppResponsive.h(size);

  /// Get responsive radius/circular size
  double r(double size) => AppResponsive.r(size);

  /// Get responsive font size
  double sp(double fontSize) => AppResponsive.sp(fontSize);

  /// Check if device is tablet
  bool get isTablet => AppResponsive.isTablet;

  /// Check if device is phone
  bool get isPhone => AppResponsive.isPhone;

  /// Screen width
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Screen height
  double get screenHeight => MediaQuery.sizeOf(this).height;
}
