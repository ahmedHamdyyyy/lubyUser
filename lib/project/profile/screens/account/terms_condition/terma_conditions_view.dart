import 'package:flutter/material.dart';
import 'wideget_terma.dart';

class TermaConditionsView extends StatefulWidget {
  const TermaConditionsView({super.key});

  @override
  State<TermaConditionsView> createState() => _TermaConditionsView();
}

class _TermaConditionsView extends State<TermaConditionsView> {
  bool _isAgreed = false;

  void _toggleAgreement() {
    setState(() {
      _isAgreed = !_isAgreed;
    });
  }

  void _handleDonePressed() {
    // Handle done button press
    // You can add functionality here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: TermsContent(
        isAgreed: _isAgreed,
        onAgreementToggle: _toggleAgreement,
        onDonePressed: _handleDonePressed,
      ),
    );
  }
}
