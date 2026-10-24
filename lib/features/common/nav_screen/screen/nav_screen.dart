import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/common/nav_screen/controller/nav_controller.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/screen/guardian_booking_screen.dart';
import 'package:home_to_school/features/role/guardian/home/presentation/screen/all_trips_screen.dart';
import 'package:home_to_school/features/role/guardian/home/presentation/screen/home_screen.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/screen/guardian_profile_screen.dart';
import 'package:home_to_school/features/message/presentation/chat_list/screen/chat_screen.dart';
import 'package:home_to_school/features/role/driver/home/presentation/screen/driver_home_screen.dart';
import 'package:home_to_school/features/role/driver/schedule/presentation/screen/driver_schedule_screen.dart';
import 'package:home_to_school/features/role/driver/profile/presentation/screen/driver_role_profile_screen.dart';
import 'package:home_to_school/features/role/walkshare/home/presentation/screen/walkshare_home_screen.dart';
import 'package:home_to_school/features/role/walkshare/schedule/presentation/screen/walkshare_schedule_screen.dart';
import 'package:home_to_school/features/role/walkshare/profile/presentation/screen/walkshare_profile_screen.dart';
import 'package:home_to_school/features/profile/presentation/screen/profile_screen.dart';
import 'package:home_to_school/services/storage/storage_services.dart';

class _RoleNavItem {
  final String label;
  final IconData activeIcon;
  final IconData inactiveIcon;
  final Widget screen;

  const _RoleNavItem({
    required this.label,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.screen,
  });
}

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  String _activeRole = '';

  @override
  void initState() {
    super.initState();
    _loadRole();
  }

  Future<void> _loadRole() async {
    await LocalStorage.getAllPrefData();
    if (mounted) {
      setState(() {
        _activeRole = LocalStorage.role.isNotEmpty
            ? LocalStorage.role
            : LocalStorage.myRole;
      });
    }
  }

  /// Check active role stored in database / SharedPreferences
  String get _currentRole {
    final role = _activeRole.isNotEmpty
        ? _activeRole
        : (LocalStorage.role.isNotEmpty
            ? LocalStorage.role
            : LocalStorage.myRole);
    return role.toLowerCase();
  }

  bool get _isDriver => _currentRole.contains('driver');
  bool get _isWalkShare => _currentRole.contains('walk');

  List<_RoleNavItem> _getNavItems([String? activeRole]) {
    final role = (activeRole ?? _currentRole).toLowerCase();
    final isDriver = role.contains('driver');
    final isWalkShare = role.contains('walk');

    if (isDriver) {
      return const [
        _RoleNavItem(
          label: 'Home',
          activeIcon: Icons.home_rounded,
          inactiveIcon: Icons.home_outlined,
          screen: DriverHomeScreen(),
        ),
        _RoleNavItem(
          label: 'Schedule',
          activeIcon: Icons.calendar_month_rounded,
          inactiveIcon: Icons.calendar_month_outlined,
          screen: DriverScheduleScreen(isTab: true),
        ),
        _RoleNavItem(
          label: 'Messages',
          activeIcon: Icons.chat_bubble_rounded,
          inactiveIcon: Icons.chat_bubble_outline_rounded,
          screen: ChatListScreen(isTab: true),
        ),
        _RoleNavItem(
          label: 'Profile',
          activeIcon: Icons.person_rounded,
          inactiveIcon: Icons.person_outline_rounded,
          screen: DriverRoleProfileScreen(isTab: true),
        ),
      ];
    }

    if (isWalkShare) {
      return const [
        _RoleNavItem(
          label: 'Home',
          activeIcon: Icons.home_rounded,
          inactiveIcon: Icons.home_outlined,
          screen: WalkshareHomeScreen(),
        ),
        _RoleNavItem(
          label: 'Schedule',
          activeIcon: Icons.calendar_month_rounded,
          inactiveIcon: Icons.calendar_month_outlined,
          screen: WalkshareScheduleScreen(isTab: true),
        ),
        _RoleNavItem(
          label: 'Messages',
          activeIcon: Icons.chat_bubble_rounded,
          inactiveIcon: Icons.chat_bubble_outline_rounded,
          screen: ChatListScreen(isTab: true),
        ),
        _RoleNavItem(
          label: 'Profile',
          activeIcon: Icons.person_rounded,
          inactiveIcon: Icons.person_outline_rounded,
          screen: WalkshareProfileScreen(isTab: true),
        ),
      ];
    }

    /// Default role: Guardian / Parent
    return const [
      _RoleNavItem(
        label: 'Home',
        activeIcon: Icons.home_rounded,
        inactiveIcon: Icons.home_outlined,
        screen: HomeScreen(),
      ),
      _RoleNavItem(
        label: 'Bookings',
        activeIcon: Icons.calendar_month_rounded,
        inactiveIcon: Icons.calendar_month_outlined,
        screen: GuardianBookingScreen(isTab: true),
      ),
      _RoleNavItem(
        label: 'Messages',
        activeIcon: Icons.chat_bubble_rounded,
        inactiveIcon: Icons.chat_bubble_outline_rounded,
        screen: ChatListScreen(isTab: true),
      ),
      _RoleNavItem(
        label: 'Profile',
        activeIcon: Icons.person_rounded,
        inactiveIcon: Icons.person_outline_rounded,
        screen: GuardianProfileScreen(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavController());

    return GetBuilder<NavController>(
      builder: (navCtrl) {
        final role = navCtrl.currentRole.isNotEmpty
            ? navCtrl.currentRole
            : (LocalStorage.role.isNotEmpty
                ? LocalStorage.role
                : (LocalStorage.myRole.isNotEmpty
                    ? LocalStorage.myRole
                    : 'Parent'));
        final navItems = _getNavItems(role);

        // Guard against out-of-bounds if role switches
        final activeIndex = navCtrl.selectedIndex >= navItems.length
            ? 0
            : navCtrl.selectedIndex;

        return Scaffold(
          backgroundColor: Colors.white,

          /// Lazy-loaded tab content using IndexedStack matching service_user_app pattern
          body: IndexedStack(
            index: activeIndex,
            children: List.generate(navItems.length, (index) {
              return activeIndex == index
                  ? navItems[index].screen
                  : const SizedBox.shrink();
            }),
          ),

          /// Bottom Navigation with rounded Card Design matching service_user_app
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                currentIndex: activeIndex,
                onTap: controller.changeIndex,
                selectedItemColor: const Color(0xFFEA580C),
                unselectedItemColor: const Color(0xFF94A3B8),
                selectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10.sp,
                ),
                iconSize: 22.sp,
                elevation: 0,
                items: List.generate(navItems.length, (index) {
                  final item = navItems[index];
                  final isSelected = activeIndex == index;

                  return BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                      child: Icon(
                        isSelected ? item.activeIcon : item.inactiveIcon,
                        size: 22.sp,
                        color: isSelected
                            ? const Color(0xFFEA580C)
                            : const Color(0xFF94A3B8),
                      ),
                    ),
                    label: item.label,
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Type alias for compatibility with service_user_app naming
typedef HomeNavScreen = NavScreen;
