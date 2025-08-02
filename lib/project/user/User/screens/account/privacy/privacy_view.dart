import 'package:flutter/material.dart';
import 'wideget_privecy.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: PrivacyContent(),
    );
  }
}
