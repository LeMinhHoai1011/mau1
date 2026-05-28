/// Base Screen Scaffold for consistent layout across screens
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

class BaseScreenScaffold extends StatelessWidget {
  final String? appBarTitle;
  final Widget child;
  final bool showAppBar;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget> appBarActions;
  final bool scrollable;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final FloatingActionButton? floatingActionButton;

  const BaseScreenScaffold({
    super.key,
    this.appBarTitle,
    required this.child,
    this.showAppBar = true,
    this.showBackButton = true,
    this.onBackPressed,
    this.appBarActions = const [],
    this.scrollable = true,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.backgroundColor,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final bodyWidget = Padding(
      padding: padding ?? EdgeInsets.zero,
      child: child,
    );

    final wrappedBody = scrollable
        ? SingleChildScrollView(
            child: bodyWidget,
          )
        : bodyWidget;

    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.background,
      appBar: showAppBar && appBarTitle != null
          ? AppBar(
              automaticallyImplyLeading: false,
              leading: showBackButton
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed:
                          onBackPressed ?? () => Navigator.pop(context),
                    )
                  : null,
              title: Text(appBarTitle!),
              centerTitle: true,
              elevation: 0,
              scrolledUnderElevation: 0.5,
              actions: appBarActions,
            )
          : null,
      body: SafeArea(child: wrappedBody),
      floatingActionButton: floatingActionButton,
    );
  }
}
