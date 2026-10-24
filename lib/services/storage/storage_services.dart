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
  static String get name => myName;
  static set name(String val) => myName = val;
  static String get email => myEmail;
  static set email(String val) => myEmail = val;
  static String get profileImage => myImage.isNotEmpty ? myImage : image;
  static set profileImage(String val) => myImage = val;
  static String myRole = '';
  static String role = '';
  static String image = '';
  static UserModel? user;

  static String vehicleType = 'Minivan';
  static String vehicleMake = 'Toyota';
  static String vehicleModel = 'Sienna';
  static String vehicleYear = '2023';
  static String vehicleColour = 'Celestial Silver';
  static String vehiclePlate = 'SCH-4091';
  static String vehicleSeats = '4';
  static String vehiclePhoto = '';

  static SharedPreferences? preferences;

  static bool get isChef => myRole.toLowerCase() == 'chef';
  static bool get isParent => (myRole.toLowerCase() == 'parent' || myRole.isEmpty) && !isDriver && !isWalkShare;
  static bool get isDriver => myRole.toLowerCase() == 'driver' || role.toLowerCase() == 'driver';
  static bool get isWalkShare => myRole.toLowerCase().contains('walk') || role.toLowerCase().contains('walk');
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

    vehicleType = localStorage.getString(LocalStorageKeys.vehicleType) ?? 'Minivan';
    vehicleMake = localStorage.getString(LocalStorageKeys.vehicleMake) ?? 'Toyota';
    vehicleModel = localStorage.getString(LocalStorageKeys.vehicleModel) ?? 'Sienna';
    vehicleYear = localStorage.getString(LocalStorageKeys.vehicleYear) ?? '2023';
    vehicleColour = localStorage.getString(LocalStorageKeys.vehicleColour) ?? 'Celestial Silver';
    vehiclePlate = localStorage.getString(LocalStorageKeys.vehiclePlate) ?? 'SCH-4091';
    vehicleSeats = localStorage.getString(LocalStorageKeys.vehicleSeats) ?? '4';
    vehiclePhoto = localStorage.getString(LocalStorageKeys.vehiclePhoto) ?? '';

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
