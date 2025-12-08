import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../core/app_router.dart';

import 'all_wideget_wallet.dart';
import 'package:luby2/core/localization/l10n_ext.dart';
import 'charging_wallet_view.dart';
// import '../propreties/widgets/bottom_nav_bar_widget.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: WalletScreenContent(
        balance: '15,000',
        currency: context.l10n.sarCurrency,
        onChargingWalletPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChargingWalletScreen(),
            ),
          );
        },
      ),
    );
  }
}
