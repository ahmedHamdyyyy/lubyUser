// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'all_widget_notfication.dart';

class NotificationDetailsReservationScreen extends StatelessWidget {
  final Map<String, dynamic> notification;

  const NotificationDetailsReservationScreen({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: notificationAppBar(context),
      body: NotificationReservationContent(notification: notification),
    );
  }
}
