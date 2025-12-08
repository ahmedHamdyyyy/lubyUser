import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../../core/app_router.dart';
import '../../bank_cards/add_card_screen.dart';

import '../../propreties/widgets/show_card_dialoge.dart';
import 'all_wideget_wallet.dart';

class ChargingWalletScreen extends StatefulWidget {
  const ChargingWalletScreen({super.key});

  @override
  State<ChargingWalletScreen> createState() => _ChargingWalletScreen();
}

class _ChargingWalletScreen extends State<ChargingWalletScreen> {
  bool _isFirstCardSelected = true;
  bool _isSecondCardSelected = false;

  void _toggleFirstCard() {
    setState(() {
      _isFirstCardSelected = true;
      _isSecondCardSelected = false;
    });
  }

  void _toggleSecondCard() {
    setState(() {
      _isFirstCardSelected = false;
      _isSecondCardSelected = true;
    });
  }

  void _handleChargePressed() {
    showCardDialoge(context);
  }

  void _handleAddNewCardPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddCardScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: ChargingWalletContent(
        isFirstCardSelected: _isFirstCardSelected,
        isSecondCardSelected: _isSecondCardSelected,
        onFirstCardToggle: _toggleFirstCard,
        onSecondCardToggle: _toggleSecondCard,
        onChargePressed: _handleChargePressed,
        onAddCardPressed: _handleAddNewCardPressed,
      ),
    );
  }
}
