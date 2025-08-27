import 'package:flutter/material.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/widget/helper.dart';


// Wallet Header Widget
class WalletHeader extends StatelessWidget {
  const WalletHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 22),
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 24,
              ),
              color: const Color(0xFF757575),
            ),
            const TextWidget(
              text: 'Wallet',
              color: Color(0xFF757575),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Padding(
          padding: EdgeInsets.only(top: 16, bottom: 24),
          child: TextWidget(
            text: 'Charging Wallet',
            color: Color(0xFF1C1C1C),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// Wallet Balance Widget
class WalletBalanceWidget extends StatelessWidget {
  const WalletBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 136,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        color: const Color(0xFF262626),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: 'Available balance',
              color: Color(0xFFFFFFFF),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                TextWidget(
                  text: '15,000',
                  color: Color(0xFFFFFFFF),
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                ),
                TextWidget(
                  text: 'SAR',
                  color: Color(0xFFFFFFFF),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Amount Input Widget
class AmountInputWidget extends StatelessWidget {
  const AmountInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const TextWidget(
          text: 'Enter Amount',
          color: Color(0xFF414141),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            enabledBorder: buildOutlineInputBorder(10),
            focusedBorder: buildOutlineInputBorder(10),
            hintText: 'Enter amount you want to charge',
            hintStyle: const TextStyle(
              color: AppColors.grayTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }
}

// Card Selection Title Widget
class CardSelectionTitleWidget extends StatelessWidget {
  const CardSelectionTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const TextWidget(
          text: 'Choose the card',
          color: Color(0xFF414141),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// Card Selection Widget
class CardSelectionWidget extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onToggle;

  const CardSelectionWidget({
    super.key,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          // ignore: deprecated_member_use
          color: Colors.grey.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      height: 142,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TextButton.icon(
                onPressed: onToggle,
                icon: isSelected
                    ? const CircleAvatar(
                        backgroundColor: Color(0xFF262626),
                        radius: 12,
                        child: CircleAvatar(
                          backgroundColor: Color(0xFFFFFFFF),
                          radius: 11,
                        ),
                      )
                    : const CircleAvatar(
                        backgroundColor: Color(0xFF262626),
                        radius: 12,
                      ),
                label: const TextWidget(
                  text: 'Use this card to Charge',
                  color: Color(0xFF414141),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 0.0, right: 272),
            child: Driver(),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: TextWidget(
              text: 'Card Name',
              color: Color(0xFF757575),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: TextWidget(
              text: 'Card number ending with 5678',
              color: Color(0xFF757575),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

// Charge Button Widget
class ChargeButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const ChargeButtonWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF262626),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const TextWidget(
          text: 'Charge',
          color: Color(0xFFFFFFFF),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

// Add New Card Button Widget
class AddNewCardButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const AddNewCardButtonWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          side: const BorderSide(
            color: Color(0xFF262626),
            width: 1.0,
            style: BorderStyle.solid,
          ),
          backgroundColor: const Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const TextWidget(
          text: 'Add New Card',
          color: Color(0xFF262626),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

// Main Charging Wallet Content Widget
class ChargingWalletContent extends StatelessWidget {
  final bool isFirstCardSelected;
  final bool isSecondCardSelected;
  final VoidCallback onFirstCardToggle;
  final VoidCallback onSecondCardToggle;
  final VoidCallback onChargePressed;
  final VoidCallback onAddCardPressed;

  const ChargingWalletContent({
    super.key,
    required this.isFirstCardSelected,
    required this.isSecondCardSelected,
    required this.onFirstCardToggle,
    required this.onSecondCardToggle,
    required this.onChargePressed,
    required this.onAddCardPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WalletHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WalletBalanceWidget(),
                  const AmountInputWidget(),
                  const CardSelectionTitleWidget(),
                  CardSelectionWidget(
                    isSelected: isFirstCardSelected,
                    onToggle: onFirstCardToggle,
                  ),
                  const SizedBox(height: 16),
                  CardSelectionWidget(
                    isSelected: isSecondCardSelected,
                    onToggle: onSecondCardToggle,
                  ),
                  const SizedBox(height: 24),
                  ChargeButtonWidget(onPressed: onChargePressed),
                  const SizedBox(height: 16),
                  AddNewCardButtonWidget(onPressed: onAddCardPressed),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// WalletScreenHeader Widget
class WalletScreenHeader extends StatelessWidget {
  const WalletScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 22),
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 24,
              ),
              color: const Color(0xFF757575),
            ),
            const TextWidget(
              text: 'Wallet',
              color: Color(0xFF757575),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
          child: TextWidget(
            text: 'Wallet',
            color: Color(0xFF1C1C1C),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// WalletBalanceCard Widget
class WalletBalanceCard extends StatelessWidget {
  final String balance;
  final String currency;
  final VoidCallback onChargingWalletPressed;

  const WalletBalanceCard({
    super.key, 
    required this.balance, 
    required this.currency,
    required this.onChargingWalletPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 184,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF262626),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              text: 'Available balance',
              color: Color(0xFFFFFFFF),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                TextWidget(
                  text: balance,
                  color: const Color(0xFFFFFFFF),
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                ),
                TextWidget(
                  text: currency,
                  color: const Color(0xFFFFFFFF),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: onChargingWalletPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const TextWidget(
                    text: 'Charging Wallet',
                    color: Color(0xFF262626),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// WalletScreenContent Widget
class WalletScreenContent extends StatelessWidget {
  final String balance;
  final String currency;
  final VoidCallback onChargingWalletPressed;
  
  const WalletScreenContent({
    super.key,
    required this.balance,
    required this.currency,
    required this.onChargingWalletPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WalletScreenHeader(),
        WalletBalanceCard(
          balance: balance,
          currency: currency,
          onChargingWalletPressed: onChargingWalletPressed,
        ),
      ],
    );
  }
}
