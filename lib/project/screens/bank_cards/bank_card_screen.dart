import 'package:flutter/material.dart';
import '../../../../../config/widget/helper.dart';
import 'add_card_screen.dart';
import 'all_wideget_bank_card.dart';

import '../../../../../config/colors/colors.dart';

class BankCardScreen extends StatelessWidget {
  const BankCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarPop(context, "Bank Cards", AppColors.primaryTextColor),
      body: BankCardsScreenContent(
        onAddCardPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCardScreen()));
        },
      ),
    );
  }
}
