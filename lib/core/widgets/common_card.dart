/// Enhanced Common Card Widget with Material 3
import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';
import '../constants/app_colors.dart';

class CommonCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final double borderRadius;
  final VoidCallback? onTap;
  final double elevation;
  final BorderSide? borderSide;
  final bool showShadow;

  const CommonCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.backgroundColor = Colors.white,
    this.borderRadius = AppSpacing.radiusLg,
    this.onTap,
    this.elevation = 0,
    this.borderSide,
    this.showShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: elevation,
        shadowColor: showShadow ? AppColors.cardShadow : Colors.transparent,
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: borderSide ?? const BorderSide(color: AppColors.borderLight, width: 1),
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

