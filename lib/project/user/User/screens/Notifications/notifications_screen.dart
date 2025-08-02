// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'all_widget_notfication.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Used to simulate presence or absence of notifications
  bool hasNotifications = true;
  int currentIndex = 0; // Track current bottom navigation bar index
  void updateCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  // List of notifications to display
  final List<Map<String, dynamic>> notifications = [
    {
      'id': 1,
      'type': 'studio',
      'title': 'Studio - 5 Nights',
      'subtitle': 'Reservation has been done',
      'date': '30/06/2024',
      'image': 'assets/images/image6.png',
    },
    {
      'id': 2,
      'type': 'activity',
      'title': 'Activity Name',
      'subtitle': 'Reservation has been done',
      'date': '4/06/2024',
      'image': 'assets/images/image7.png',
    },
    {
      'id': 3,
      'type': 'notification',
      'title': 'Notification Name',
      'subtitle': 'Lorem ipsum dolor sit amet',
      'date': '4/05/2024',
      'image': "assets/images/Layer_1.png",
    },
    {
      'id': 4,
      'type': 'studio',
      'title': 'Studio - 5 Nights',
      'subtitle': 'Reservation has been done',
      'date': '27/04/2024',
      'image': 'assets/images/image6.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: notificationsListAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            NotificationsListTitle(
              onTap: () {
                setState(() {
                  hasNotifications = !hasNotifications;
                });
              },
            ),
            hasNotifications 
                ? NotificationsList(notifications: notifications) 
                : const EmptyNotificationsState(),
          ],
        ),
      ),
     
    );
  }
}
