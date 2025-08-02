import 'package:flutter/material.dart';
import 'wideget_host_us.dart';

class HostWithUsView extends StatelessWidget {
  const HostWithUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: HostWithUsContent(
        onRegisterPressed: () {
          // Handle registration action
          // You can add functionality here
        },
      ),
    );
  }
}
