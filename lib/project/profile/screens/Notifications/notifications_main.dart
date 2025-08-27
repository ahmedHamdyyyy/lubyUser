import 'package:flutter/material.dart';
import 'notifications_screen.dart';

// هذا الملف يمكن استخدامه كنقطة دخول لقسم الإشعارات
class NotificationsMain extends StatelessWidget {
  const NotificationsMain({super.key});

  @override
  Widget build(BuildContext context) {
    // توجيه مباشر إلى شاشة الإشعارات الرئيسية
    return const NotificationsScreen();
  }
}

// يمكن استخدام هذه الدالة للتنقل إلى قسم الإشعارات من أي مكان في التطبيق
void navigateToNotifications(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const NotificationsMain(),
    ),
  );
} 