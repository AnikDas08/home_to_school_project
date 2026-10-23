import 'package:get/get.dart';

class AppNotificationItem {
  final String id;
  final String title;
  final String message;
  final String time;
  bool isRead;

  AppNotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
  });
}

class NotificationsController extends GetxController {
  static NotificationsController get instance =>
      Get.find<NotificationsController>();

  /// Selected tab: 0 = All, 1 = Unread
  int selectedTabIndex = 0;

  /// Notifications mock dataset matching design
  final List<AppNotificationItem> notifications = [
    AppNotificationItem(
      id: '1',
      title: 'Driver 5 Mins Away',
      message:
          'Tariq Ahmed is approaching 12 Elm Street for morning school pickup.',
      time: 'Just now',
      isRead: false,
    ),
    AppNotificationItem(
      id: '2',
      title: 'Schedule Confirmed',
      message:
          'Recurring school commute for Arman & Emma confirmed for next week.',
      time: '1 hr ago',
      isRead: false,
    ),
    AppNotificationItem(
      id: '3',
      title: 'Safety Protocol Active',
      message:
          'All 3 emergency safety contacts verified and synced with school dispatch.',
      time: 'Yesterday',
      isRead: true,
    ),
    AppNotificationItem(
      id: '4',
      title: 'Rate Your Last Ride',
      message:
          'Help maintain high safety standards by leaving feedback for Tariq Ahmed.',
      time: 'May 21',
      isRead: true,
    ),
  ];

  /// Get total count of notifications
  int get allCount => notifications.length;

  /// Get unread count
  int get unreadCount => notifications.where((n) => !n.isRead).length;

  /// Filtered list based on active tab
  List<AppNotificationItem> get filteredNotifications {
    if (selectedTabIndex == 1) {
      return notifications.where((n) => !n.isRead).toList();
    }
    return notifications;
  }

  /// Change filter tab
  void selectTab(int index) {
    if (selectedTabIndex == index) return;
    selectedTabIndex = index;
    update();
  }

  /// Mark all as read
  void markAllAsRead() {
    for (final item in notifications) {
      item.isRead = true;
    }
    update();
  }

  /// Toggle read status for individual notification
  void toggleRead(String id) {
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      notifications[index].isRead = !notifications[index].isRead;
      update();
    }
  }
}
