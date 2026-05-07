// Updated App with all providers & routes
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_colors.dart';
import 'providers/auth_provider.dart';
import 'providers/document_provider.dart';
import 'providers/search_provider.dart';
import 'providers/library_provider.dart';
import 'providers/settings_provider.dart';
import 'views/home/home_screen.dart';
import 'views/discovery/discovery_screen.dart';
import 'views/library/library_screen.dart';
import 'views/notification/notification_screen.dart';
import 'views/profile/profile_screen.dart';
import 'views/auth/auth_wrapper.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthProvider _authProvider;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _authProvider = AuthProvider();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _authProvider.initAuth();
    if (mounted) {
      setState(() => _isInitialized = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _authProvider),
        ChangeNotifierProvider(create: (_) => DocumentProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => LibraryProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const AuthWrapper(),
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    DiscoveryScreen(),
    LibraryScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Khám phá'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Thư viện'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Thông báo'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cá nhân'),
        ],
      ),
    );
  }
}
