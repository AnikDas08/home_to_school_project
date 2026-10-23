import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/common/auth/data/datasources/auth_remote_datasource.dart';
import 'package:home_to_school/features/common/auth/data/repositories/auth_repository_impl.dart';
import 'package:home_to_school/features/common/auth/domain/repositories/auth_repository.dart';
import 'package:home_to_school/utils/app_snackbar.dart';

class SignInController extends GetxController {
  final AuthRepository _authRepository;

  SignInController({AuthRepository? authRepository})
      : _authRepository = authRepository ??
            AuthRepositoryImpl(
              remoteDataSource: AuthRemoteDataSourceImpl(),
            );

  bool isLoading = false;
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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

    // Direct navigation for design phase (API call commented out)
    Get.offAllNamed(AppRoutes.home);

    // if (isLoading) return;
    // try {
    //   isLoading = true;
    //   update();
    //   await _authRepository.signIn(
    //     email: emailController.text.trim(),
    //     password: passwordController.text.trim(),
    //   );
    //   Get.offAllNamed(AppRoutes.home);
    // } catch (e) {
    //   AppSnackbar.error(
    //     title: 'Sign In Failed',
    //     message: e.toString().replaceAll('Exception: ', ''),
    //   );
    // } finally {
    //   isLoading = false;
    //   update();
    // }
  }

  void signInWithApple() {
    Get.offAllNamed(AppRoutes.home);
  }

  void signInWithGoogle() {
    Get.offAllNamed(AppRoutes.home);
  }

  @override
  void onClose() {
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
