import 'dart:async';
import 'package:flutter/material.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/common/auth/data/datasources/auth_remote_datasource.dart';
import 'package:home_to_school/features/common/auth/data/repositories/auth_repository_impl.dart';
import 'package:home_to_school/features/common/auth/domain/repositories/auth_repository.dart';
import 'package:home_to_school/utils/app_snackbar.dart';
import 'package:home_to_school/utils/helpers/other_helper.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:home_to_school/services/storage/storage_services.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find<SignUpController>();

  final AuthRepository _authRepository;

  SignUpController({AuthRepository? authRepository})
      : _authRepository = authRepository ??
            AuthRepositoryImpl(
              remoteDataSource: AuthRemoteDataSourceImpl(),
            );

  bool isLoading = false;
  bool isLoadingVerify = false;
  bool isTermsAccepted = false;
  final List<String> availableRoles = ['Parent', 'Student', 'Driver'];
  String selectRole = 'Parent';
  String countryCode = '+880';
  String? image;
  String signUpToken = '';
  Timer? _timer;
  int _seconds = 25;

  TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController {
    try {
      final _ = _nameController.value;
      return _nameController;
    } catch (_) {
      _nameController = TextEditingController();
      return _nameController;
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

  TextEditingController _numberController = TextEditingController();
  TextEditingController get numberController {
    try {
      final _ = _numberController.value;
      return _numberController;
    } catch (_) {
      _numberController = TextEditingController();
      return _numberController;
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

  String get time {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void onCountryChange(Country value) {
    countryCode = value.dialCode;
  }

  void setSelectedRole(String value) {
    selectRole = value;
    update();
  }

  void toggleTermsAccepted() {
    isTermsAccepted = !isTermsAccepted;
    update();
  }

  Future<void> openGallery() async {
    image = await OtherHelper.pickImage();
    update();
  }

  Future<void> signUpUser() async {
    if (!isTermsAccepted) {
      AppSnackbar.error(
        title: 'Terms & Privacy',
        message: 'Please agree to the Terms & conditions & Privacy Policy',
      );
      return;
    }

    Get.toNamed(AppRoutes.verifyUser);

    // if (isLoading) return;
    // try {
    //   isLoading = true;
    //   update();
    //
    //   await _authRepository.signUp(
    //     name: nameController.text.trim(),
    //     email: emailController.text.trim(),
    //     password: passwordController.text.trim(),
    //   );
    //
    //   Get.toNamed(AppRoutes.verifyUser);
    // } catch (e) {
    //   AppSnackbar.error(title: 'Error', message: e.toString());
    // } finally {
    //   isLoading = false;
    //   update();
    // }
  }

  void startTimer() {
    _timer?.cancel();
    _seconds = 25;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        timer.cancel();
        update();
        return;
      }
      _seconds--;
      update();
    });
  }

  Future<void> verifyOtp() async {
    final storedRole = LocalStorage.role.toLowerCase();
    final currentRole = selectRole.toLowerCase();
    final isDriver = storedRole.contains('driver') ||
        currentRole.contains('driver') ||
        storedRole.contains('carpool') ||
        currentRole.contains('carpool');
    final isWalkShare = storedRole.contains('walk') ||
        currentRole.contains('walk');
    final isGuardian = storedRole.contains('parent') ||
        storedRole.contains('guardian') ||
        currentRole.contains('parent') ||
        currentRole.contains('guardian');

    if (isDriver) {
      Get.toNamed(AppRoutes.driverLicence);
    } else if (isWalkShare) {
      Get.toNamed(AppRoutes.walkshareVerification);
    } else if (isGuardian) {
      Get.toNamed(AppRoutes.addChild);
    } else {
      Get.offAllNamed(AppRoutes.signIn);
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
