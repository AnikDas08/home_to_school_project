import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/common/auth/data/datasources/auth_remote_datasource.dart';
import 'package:home_to_school/features/common/auth/data/repositories/auth_repository_impl.dart';
import 'package:home_to_school/features/common/auth/domain/repositories/auth_repository.dart';
import 'package:home_to_school/utils/app_snackbar.dart';
import 'package:home_to_school/utils/enum/enum.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final AuthRepository _authRepository;

  ForgetPasswordController({AuthRepository? authRepository})
      : _authRepository = authRepository ??
            AuthRepositoryImpl(
              remoteDataSource: AuthRemoteDataSourceImpl(),
            );

  @override
  void onInit() {
    super.onInit();
    setValue();
  }

  static ForgetPasswordController get instance =>
      Get.find<ForgetPasswordController>();

  void setValue() {
    if (kDebugMode) return;
    emailController.text = 'developernaimul00@gmail.com';
    otpController.text = '123456';
    passwordController.text = 'hello123';
    confirmPasswordController.text = 'hello123';
  }

  bool isLoading = false;
  ForgetPasswordStep currentStep = ForgetPasswordStep.email;
  String forgetPasswordToken = '';
  static const int _otpDurationSeconds = 180;
  int remainingSeconds = 0;
  Timer? _timer;
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

  TextEditingController _otpController = TextEditingController();
  TextEditingController get otpController {
    try {
      final _ = _otpController.value;
      return _otpController;
    } catch (_) {
      _otpController = TextEditingController();
      return _otpController;
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

  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController get confirmPasswordController {
    try {
      final _ = _confirmPasswordController.value;
      return _confirmPasswordController;
    } catch (_) {
      _confirmPasswordController = TextEditingController();
      return _confirmPasswordController;
    }
  }

  bool get canResendOtp => remainingSeconds == 0;

  String get timerText {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void startOtpTimer() {
    _timer?.cancel();
    remainingSeconds = _otpDurationSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
      } else {
        remainingSeconds--;
        update();
      }
    });
  }

  Future<void> sendForgetPasswordEmail() async {
    try {
      _setLoading(true);
      await _authRepository.forgotPassword(email: emailController.text.trim());
      currentStep = ForgetPasswordStep.otp;
      startOtpTimer();
      Get.toNamed(AppRoutes.verifyEmail);
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> verifyOtp() async {
    currentStep = ForgetPasswordStep.resetPassword;
    Get.toNamed(AppRoutes.createPassword);
  }

  Future<void> resetPassword() async {
    AppSnackbar.success(title: 'Success', message: 'Password reset successfully');
    _clearAll();
    Get.offAllNamed(AppRoutes.signIn);
  }

  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  void _clearAll() {
    emailController.clear();
    otpController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    _timer?.cancel();
    remainingSeconds = 0;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
