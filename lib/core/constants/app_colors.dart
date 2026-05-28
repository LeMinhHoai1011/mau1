import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF1A56DB); // Main blue for EduShare
  static const Color primaryLight = Color(0xFFE3EEFF); // Light variant
  static const Color primaryDark = Color(0xFF0F3DCC); // Dark variant

  // Secondary colors
  static const Color secondary = Color(0xFF00D9FF); // Cyan for accent
  static const Color secondaryLight = Color(0xFFD1F7FF);
  static const Color secondaryDark = Color(0xFF00A8CC);

  // Status colors
  static const Color success = Color(0xFF10B981); // Green
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color error = Color(0xFFEF4444); // Red
  static const Color info = Color(0xFF3B82F6); // Light blue

  // Neutral colors
  static const Color background = Color(0xFFF8F9FE);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF3F4F6);

  // Text colors
  static const Color textMain = Color(0xFF111827); // Primary text
  static const Color textSecondary = Color(0xFF6B7280); // Secondary text
  static const Color textDisabled = Color(0xFFD1D5DB); // Disabled text
  static const Color textHint = Color(0xFF9CA3AF); // Hint text

  // Border and divider
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderMedium = Color(0xFFD1D5DB);
  static const Color divider = Color(0xFFE5E7EB);

  // Shadow color
  static const Color cardShadow = Color(0x1A000000);

  // Gradient colors
  static const List<Color> gradientPrimary = [primary, Color(0xFF1D4FD7)];
  static const List<Color> gradientSuccess = [success, Color(0xFF059669)];
}
