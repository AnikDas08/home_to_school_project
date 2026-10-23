import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/route/app_routes.dart';
import '../../features/profile/data/model/user_model.dart';
import '../../utils/log/app_log.dart';
import 'storage_keys.dart';

class LocalStorage {
  static String token = '';
  static String refreshToken = '';
  static bool isLogIn = false;
  static String userId = '';
  static String myImage = '';
  static String myName = '';
  static String myEmail = '';
  static String myRole = '';
  static String role = '';
  static String image = '';
  static UserModel? user;

  static SharedPreferences? preferences;

  static bool get isChef => myRole.toLowerCase() == 'chef';
  static bool get isParent => myRole.toLowerCase() == 'parent' || myRole.isEmpty;
  static bool get isDriver => myRole.toLowerCase() == 'driver';
  static bool get isStudent => myRole.toLowerCase() == 'student';

  static Future<SharedPreferences> _getStorage() async {
    preferences ??= await SharedPreferences.getInstance();
    return preferences!;
  }

  /// Get All Data From SharedPreferences
  static Future<void> getAllPrefData() async {
    final localStorage = await _getStorage();

    token = localStorage.getString(LocalStorageKeys.token) ?? '';
    refreshToken = localStorage.getString(LocalStorageKeys.refreshToken) ?? '';
    isLogIn = localStorage.getBool(LocalStorageKeys.isLogIn) ?? false;
    userId = localStorage.getString(LocalStorageKeys.userId) ?? '';
    myImage = localStorage.getString(LocalStorageKeys.myImage) ?? '';
    myName = localStorage.getString(LocalStorageKeys.myName) ?? '';
    myEmail = localStorage.getString(LocalStorageKeys.myEmail) ?? '';
    myRole = localStorage.getString(LocalStorageKeys.myRole) ?? '';
    role = localStorage.getString(LocalStorageKeys.role) ?? myRole;
    if (myRole.isEmpty && role.isNotEmpty) {
      myRole = role;
    }

    appLog(userId, source: 'Local Storage');
  }

  /// Save Selected Role To SharedPreferences and LocalStorage
  static Future<void> saveRole(String selectedRole) async {
    role = selectedRole;
    myRole = selectedRole;
    await setString(LocalStorageKeys.role, selectedRole);
    await setString(LocalStorageKeys.myRole, selectedRole);
  }

  /// Remove All Data From SharedPreferences
  static Future<void> removeAllPrefData() async {
    final localStorage = await _getStorage();
    await localStorage.clear();
    _resetLocalStorageData();
    Get.offAllNamed(AppRoutes.signIn);
    await getAllPrefData();
  }

  // Reset LocalStorage Data
  static void _resetLocalStorageData() {
    final localStorage = preferences!;
    localStorage.setString(LocalStorageKeys.token, '');
    localStorage.setString(LocalStorageKeys.refreshToken, '');
    localStorage.setString(LocalStorageKeys.userId, '');
    localStorage.setString(LocalStorageKeys.myImage, '');
    localStorage.setString(LocalStorageKeys.myName, '');
    localStorage.setString(LocalStorageKeys.myEmail, '');
    localStorage.setBool(LocalStorageKeys.isLogIn, false);
  }

  // Save Data To SharedPreferences
  static Future<void> setString(String key, String value) async {
    final localStorage = await _getStorage();
    await localStorage.setString(key, value);
  }

  static Future<void> setBool(String key, bool value) async {
    final localStorage = await _getStorage();
    await localStorage.setBool(key, value);
  }

  static Future<void> setInt(String key, int value) async {
    final localStorage = await _getStorage();
    await localStorage.setInt(key, value);
  }
}
