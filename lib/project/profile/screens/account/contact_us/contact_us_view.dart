import 'package:flutter/material.dart';
import 'wideget_contact.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: ContactUsContent(
          onSendPressed: () {
            // Handle sending message
            // You can add any action here
          },
        ),
      ),
      //bottomNavigationBar: const BottomNavBarWidget(),
    );
  }
}
