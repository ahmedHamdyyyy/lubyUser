import 'package:flutter/material.dart';

import 'all_widget_notfication.dart';

class NotificationDetailScreen extends StatelessWidget {
  final Map<String, dynamic> notification;

  const NotificationDetailScreen({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: notificationAppBar(context),
      body: NotificationDetailContent(notification: notification),
    );
  }
}
