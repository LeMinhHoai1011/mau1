// Custom Button Widget
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'button_type.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
final IconData? icon;
final bool isLoading;
final ButtonType type;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;



  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.type = ButtonType.primary,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        return _buildElevatedButton();
      case ButtonType.secondary:
        return _buildSecondaryButton();
      case ButtonType.outlined:
        return _buildOutlinedButton();
    }
    return _buildElevatedButton(); // default
  }

  Widget _buildElevatedButton() {
    return ElevatedButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon: isLoading
          ? SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : (icon != null ? Icon(icon) : SizedBox.shrink()),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton() {
    return ElevatedButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon: icon != null ? Icon(icon) : SizedBox.shrink(),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        foregroundColor: AppColors.primary,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  Widget _buildOutlinedButton() {
    return OutlinedButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon: icon != null ? Icon(icon) : SizedBox.shrink(),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
