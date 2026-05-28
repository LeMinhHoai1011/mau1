import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/router/router_helper.dart';
import '../../providers/auth_provider.dart';
import '../auth/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.menu_book, color: AppColors.primary, size: 32),
                  const SizedBox(width: 8),
                  Text(
                    'EduShare',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Hình minh họa
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Icon(Icons.laptop_chromebook, size: 100, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: 40),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textMain),
                  children: [
                    const TextSpan(text: 'Nâng tầm '),
                    TextSpan(text: 'học tập\n', style: TextStyle(color: AppColors.primary)),
                    const TextSpan(text: 'cùng nhau'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Tham gia cộng đồng sinh viên toàn cầu chia sẻ tài liệu, ghi chép và kiến thức học thuật.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 16, height: 1.5),
              ),
              const Spacer(),
              // Page Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 24, height: 8, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(4))),
                  const SizedBox(width: 8),
                  Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFE5E7EB), shape: BoxShape.circle)),
                  const SizedBox(width: 8),
                  Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFE5E7EB), shape: BoxShape.circle)),
                ],
              ),
              const SizedBox(height: 32),
              
              // ✅ Nút "Bắt đầu ngay" - lưu isFirstTime + chuyển Login
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    // Lưu trạng thái first time
                    await context.read<AuthProvider>().completeOnboarding();
                    
                    // 🔀 Chuyển sang LoginScreen (xóa stack)
                    if (context.mounted) {
                      RouterHelper.goLogin(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Bắt đầu ngay', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
              
              // ✅ Nút "Đăng nhập" - bỏ qua onboarding, không lưu gì cả
              TextButton(
                onPressed: () {
                  // 🔀 Bỏ qua onboarding, đi đến login (xóa stack)
                  RouterHelper.goLogin(context);
                },
                child: const Text('Đăng nhập', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
