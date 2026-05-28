/// Enhanced Custom Button with Material 3 support
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import 'button_type.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isLoading;
  final ButtonType type;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final bool isFullWidth;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.type = ButtonType.primary,
    this.padding,
    this.borderRadius = AppSpacing.radiusMd,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonContent = switch (type) {
      ButtonType.primary => _buildElevatedButton(),
      ButtonType.secondary => _buildSecondaryButton(),
      ButtonType.outlined => _buildOutlinedButton(),
    };

    return isFullWidth ? SizedBox(width: double.infinity, child: buttonContent) : buttonContent;
  }

  Widget _buildElevatedButton() {
    return ElevatedButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon: _buildIcon(),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: padding ??
            const EdgeInsets.symmetric(
              vertical: AppSpacing.md,
              horizontal: AppSpacing.lg,
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton() {
    return ElevatedButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon: _buildIcon(color: AppColors.secondary),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondaryLight,
        foregroundColor: AppColors.secondary,
        padding: padding ??
            const EdgeInsets.symmetric(
              vertical: AppSpacing.md,
              horizontal: AppSpacing.lg,
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  Widget _buildOutlinedButton() {
    return OutlinedButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon: _buildIcon(color: AppColors.primary),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        padding: padding ??
            const EdgeInsets.symmetric(
              vertical: AppSpacing.md,
              horizontal: AppSpacing.lg,
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  Widget _buildIcon({Color? color}) {
    if (isLoading) {
      return SizedBox(
        width: AppSpacing.iconSmall,
        height: AppSpacing.iconSmall,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(color ?? Colors.white),
        ),
      );
    }
    if (icon != null) {
      return Icon(icon, color: color);
    }
    return const SizedBox.shrink();
  }
}
