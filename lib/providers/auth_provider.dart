// Auth Provider with SharedPreferences
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/user_model.dart';
import '../data/database/user_dao.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  bool _isFirstTime = true;
  bool _isLoggedIn = false;
  String? _errorMessage;
  final UserDAO _userDAO = UserDAO();
  
  // Keys for SharedPreferences
  static const String _keyFirstTime = 'isFirstTime';
  static const String _keyIsLoggedIn = 'isLoggedIn';

  // Getters
  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isFirstTime => _isFirstTime;
  bool get isLoggedIn => _isLoggedIn;
  bool get isAuthenticated => _currentUser != null && _isLoggedIn;
  String? get errorMessage => _errorMessage;

  // Initialize - Call this in main() before runApp()
  Future<void> initAuth() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      _isFirstTime = prefs.getBool(_keyFirstTime) ?? true;
      _isLoggedIn = prefs.getBool(_keyIsLoggedIn) ?? false;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Login - hỗ trợ cả email và phone
  Future<bool> login(String emailOrPhone, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      UserModel? user;
      
      // Kiểm tra xem là email hay phone
      if (emailOrPhone.contains('@')) {
        // Email format
        user = await _userDAO.getUserByEmail(emailOrPhone);
      } else {
        // Phone format
        user = await _userDAO.getUserByPhone(emailOrPhone);
      }
      
      if (user != null) {
        _currentUser = user;
        _isLoggedIn = true;
        
        // Save state
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(_keyIsLoggedIn, true);
        
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Email hoặc số điện thoại không tồn tại';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Register - automatically logs in
  Future<bool> register(String name, String email, String phone, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        phone: phone,
      );
      await _userDAO.insertUser(newUser);
      
      _currentUser = newUser;
      _isLoggedIn = true;
      
      // Save state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyIsLoggedIn, true);
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Complete onboarding - mark as not first time anymore
  Future<void> completeOnboarding() async {
    _isFirstTime = false;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyFirstTime, false);
    
    notifyListeners();
  }

  // Logout - clear login state but NOT firstTime (so won't show onboarding again)
  Future<void> logout() async {
    _currentUser = null;
    _isLoggedIn = false;
    _errorMessage = null;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, false);
    // KHÔNG xóa isFirstTime để không hiện onboarding nữa
    
    notifyListeners();
  }

  // Update profile
  Future<bool> updateProfile(UserModel user) async {
    try {
      await _userDAO.updateUser(user);
      _currentUser = user;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
