// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/widget/helper.dart';
import 'all_widget__complete_reservation_and_payment.dart';
import 'thank_you_screen.dart';
import '../Conversations/chat_screen.dart';

class ConfirmedPaymentScreen extends StatelessWidget {
  final String vendorId;
  const ConfirmedPaymentScreen({super.key, required this.vendorId});

  @override
  Widget build(BuildContext context) {
    // Define reservation items
    final List<Map<String, String>> reservationItems = [
      {
        'imagePath': 'assets/images/saudian_man.png',
        'title': 'Studio - 5 Night',
        'hostName': 'Mohamed Abdallah',
      },
      {
        'imagePath': 'assets/images/saudian_man.png',
        'title': 'Activity Name - 2 person',
        'hostName': 'Mohamed Abdallah',
      },
    ];

    // Define summary items
    final List<Map<String, String>> summaryItems = [
      {'title': '5 nights × 800', 'value': '4000 SAR'},
      {'title': '2 Person × 800', 'value': '4000 SAR'},
      {'title': 'Vat', 'value': '0 SAR'},
      {'title': 'Discount', 'value': '200 SAR'},
      {'title': 'Discount', 'value': '1000 SAR'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarPop(context, "Confirmed reservation", AppColors.primary),
      body: ConfirmedPaymentScreenContent(
        reservationNumber: '1234',
        reservationItems: reservationItems,
        summaryItems: summaryItems,
        onDonePressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ThankYouScreen()),
          );
        },
        onMessagePressed: (hostName, imagePath) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                vendorId: vendorId,
                userName: hostName,
                userImage: imagePath,
              ),
            ),
          );
        },
      ),
    );
  }
}
