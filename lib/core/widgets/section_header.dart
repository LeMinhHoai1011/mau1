/// Section Header Widget for screen sections
import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;
  final TextStyle? titleStyle;

  const SectionHeader({
    super.key,
    required this.title,
    this.onViewAll,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: titleStyle ?? Theme.of(context).textTheme.headlineSmall,
          ),
          if (onViewAll != null)
            TextButton(
              onPressed: onViewAll,
              child: const Text('Xem tất cả'),
            ),
        ],
      ),
    );
  }
}
