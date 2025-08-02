import 'package:flutter/material.dart';

import 'all_widget__complete_reservation_and_payment.dart';
import 'payment_method_screen.dart';


class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  bool isApplied = false;
  bool showSuccessMessage = false;
  final TextEditingController _promoCodeController = TextEditingController();

  @override
  void dispose() {
    _promoCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define rental items
    final List<Map<String, dynamic>> rentalItems = [
      {
        'imagePath': 'assets/images/image6.png',
        'title': 'Studio - 5 Night',
        'location': 'Riyadh - District Name',
        'dateDetails': 'Check-in  14/10/2024\nCheck-out 19/10/2024',
        'price': '4000 SAR',
        'onEdit': () {
          // Handle edit action
        },
        'onDelete': () {
          // Handle delete action
        },
      },
    ];

    // Define activity items
    final List<Map<String, dynamic>> activityItems = [
      {
        'imagePath': 'assets/images/image7.png',
        'title': 'Activity Name',
        'location': '2 person\nRiyadh - District Name',
        'dateDetails': 'Date  14/10/2024',
        'price': '4000 SAR',
        'onEdit': () {
          // Handle edit action
        },
        'onDelete': () {
          // Handle delete action
        },
      },
    ];

    // Define summary items
    final List<Map<String, String>> summaryItems = [
      {'title': '5 nights × 800', 'value': '4000 SAR'},
      {'title': '2 Person × 800', 'value': '4000 SAR'},
      {'title': 'Vat', 'value': '0 SAR'},
    ];

    // Define promo code input
    final promoCodeInput = PromoCodeInputWidget(
      controller: _promoCodeController,
      buttonText: isApplied ? "Apply" : "Submit",
      hintText: "Enter the promo code",
      isApplied: isApplied,
      onApplyPressed: () {
        setState(() {
          isApplied = true;
          showSuccessMessage = true;
        });
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SummaryScreenContent(
        rentalItems: rentalItems,
        activityItems: activityItems,
        summaryItems: summaryItems,
        promoCodeInput: promoCodeInput,
        showSuccessMessage: showSuccessMessage,
        isApplied: isApplied,
        discountText: "After Discount",
        savedAmount: "(You Saved 100 SAR)",
        finalPrice: "900 SAR",
        onPaymentMethodPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentMethodScreen(),
            ),
          );
        },
      ),
    );
  }
}
