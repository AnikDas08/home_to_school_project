import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/common/auth/data/datasources/auth_remote_datasource.dart';
import 'package:home_to_school/features/common/auth/data/repositories/auth_repository_impl.dart';
import 'package:home_to_school/features/common/auth/domain/repositories/auth_repository.dart';
import 'package:home_to_school/features/common/nav_screen/controller/nav_controller.dart';
import 'package:home_to_school/services/storage/storage_services.dart';
import 'package:home_to_school/utils/app_snackbar.dart';

class SignInController extends GetxController {
  final AuthRepository _authRepository;

  SignInController({AuthRepository? authRepository})
      : _authRepository = authRepository ??
            AuthRepositoryImpl(
              remoteDataSource: AuthRemoteDataSourceImpl(),
            );

  bool isLoading = false;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController get phoneController {
    try {
      final _ = _phoneController.value;
      return _phoneController;
    } catch (_) {
      _phoneController = TextEditingController();
      return _phoneController;
    }
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController {
    try {
      final _ = _emailController.value;
      return _emailController;
    } catch (_) {
      _emailController = TextEditingController();
      return _emailController;
    }
  }

  TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController {
    try {
      final _ = _passwordController.value;
      return _passwordController;
    } catch (_) {
      _passwordController = TextEditingController();
      return _passwordController;
    }
  }

  String countryCode = '+1';
  String countryFlag = '🇨🇦';

  final List<Map<String, String>> countryList = [
    {'flag': '🇨🇦', 'code': '+1', 'name': 'Canada'},
    {'flag': '🇺🇸', 'code': '+1', 'name': 'United States'},
    {'flag': '🇬🇧', 'code': '+44', 'name': 'United Kingdom'},
    {'flag': '🇦🇺', 'code': '+61', 'name': 'Australia'},
    {'flag': '🇧🇩', 'code': '+880', 'name': 'Bangladesh'},
  ];

  void setCountry(String flag, String code) {
    countryFlag = flag;
    countryCode = code;
    update();
  }

  Future<void> signInUser() async {
    if (phoneController.text.trim().isEmpty) {
      AppSnackbar.error(
        title: 'Phone Number Required',
        message: 'Please enter your mobile number',
      );
      return;
    }

    /// 1. Refresh stored role from local database / SharedPreferences
    await LocalStorage.getAllPrefData();

    /// 2. If API is called, sign in and extract the user's role from the database
    if (emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty) {
      if (isLoading) return;
      try {
        isLoading = true;
        update();
        await _authRepository.signIn(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } catch (e) {
        debugPrint('Sign in API note: $e');
      } finally {
        isLoading = false;
        update();
      }
    }

    /// 3. Reset NavController to Home tab (index 0)
    if (Get.isRegistered<NavController>()) {
      Get.find<NavController>().resetToHome();
    }

    /// 4. Navigate to NavScreen which automatically opens the stored role's screens
    Get.offAllNamed(AppRoutes.navScreen);
  }

  Future<void> signInWithApple() async {
    await LocalStorage.getAllPrefData();
    if (Get.isRegistered<NavController>()) {
      Get.find<NavController>().resetToHome();
    }
    Get.offAllNamed(AppRoutes.navScreen);
  }

  Future<void> signInWithGoogle() async {
    await LocalStorage.getAllPrefData();
    if (Get.isRegistered<NavController>()) {
      Get.find<NavController>().resetToHome();
    }
    Get.offAllNamed(AppRoutes.navScreen);
  }

  @override
  void onClose() {
    // Avoid calling dispose on TextEditingControllers to prevent
    // 'A TextEditingController was used after being disposed' crash on navigation
    super.onClose();
  }
}
