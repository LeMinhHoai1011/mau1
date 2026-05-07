// AuthWrapper - Auto navigation based on auth state
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../onboarding/onboarding_screen.dart';
import '../auth/login_screen.dart';
import '../../app.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        // Show loading while checking auth state
        if (authProvider.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Navigation flow:
        // 1. First time → Onboarding
        // 2. Not logged in → Login
        // 3. Logged in → MainApp
        if (authProvider.isFirstTime) {
          return const OnboardingScreen();
        } else if (!authProvider.isLoggedIn) {
          return const LoginScreen();
        } else {
          return const MainApp();
        }
      },
    );
  }
}
