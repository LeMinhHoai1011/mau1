/// Responsive design configuration and constraints
class AppResponsive {
  // Screen size breakpoints (width in logical pixels)
  static const double mobileSmall = 360;
  static const double mobileMedium = 480;
  static const double mobileLarge = 600;
  static const double tablet = 800;
  static const double desktop = 1200;

  // Utility method to check screen size
  static ScreenSize getScreenSize(double width) {
    if (width < mobileMedium) {
      return ScreenSize.small;
    } else if (width < tablet) {
      return ScreenSize.medium;
    } else {
      return ScreenSize.large;
    }
  }

  // Max widths for constrained layouts
  static const double maxContentWidth = 600;
  static const double maxDialogWidth = 500;

  // Safe area margins (for notched devices)
  static const double safeAreaMargin = 16;

  // Grid columns for responsive grid
  static int getGridColumns(double width) {
    if (width < tablet) return 2;
    if (width < desktop) return 3;
    return 4;
  }
}

enum ScreenSize { small, medium, large }

extension ScreenSizeExt on ScreenSize {
  bool get isSmall => this == ScreenSize.small;
  bool get isMedium => this == ScreenSize.medium;
  bool get isLarge => this == ScreenSize.large;
}
