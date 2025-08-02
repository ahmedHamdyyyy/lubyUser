// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';

import '../../../../../../config/images/image_assets.dart';
import 'all_widget__complete_reservation_and_payment.dart';
import 'confirm_payment.dart';


class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int selectedPaymentMethod = 0;
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expirationController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _promoCodeController = TextEditingController();
  bool _saveData = false;
  String _rawCardNumber = '';
  bool _isCardNumberValid = false;
  bool _isExpirationValid = false;
  bool _isCvvValid = false;
  bool _isCardNameValid = false;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expirationController.dispose();
    _cvvController.dispose();
    _cardNameController.dispose();
    _promoCodeController.dispose();
    super.dispose();
  }

  // Format the card number with spaces after every 4 digits (visible during input)
  String formatCardNumber(String input) {
    // Remove all non-digit characters
    String cleanInput = input.replaceAll(RegExp(r'\D'), '');
    _rawCardNumber = cleanInput;
    
    // Check if card number is valid (simple length check)
    _isCardNumberValid = cleanInput.length == 16;

    // Format with spaces for display
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < cleanInput.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(cleanInput[i]);
    }
    return buffer.toString();
  }

  // Format visible card number with masking (● for first 12 digits)
  String obscureCardNumber(String formattedInput) {
    if (_rawCardNumber.length <= 4) return formattedInput;
    
    // Create a masked version showing only last 4 digits
    String lastFourDigits = _rawCardNumber.substring(_rawCardNumber.length - 4);
    String maskedPart = "●●●● ●●●● ●●●● ";
    
    return maskedPart + lastFourDigits;
  }
  
  // Validate and format expiration date (MM/YY)
  void handleExpirationInput(String value) {
    // Remove any non-digit characters
    String digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    
    if (digitsOnly.isEmpty) {
      _expirationController.text = '';
      _isExpirationValid = false;
      return;
    }
    
    // Handle the formatting logic for MM/YY
    String formatted = '';
    
    if (digitsOnly.isNotEmpty) {
      // First digit of month can only be 0 or 1
      int firstDigit = int.parse(digitsOnly[0]);
      if (firstDigit > 1) {
        digitsOnly = '0$digitsOnly';
      }
    }
    
    if (digitsOnly.length >= 2) {
      // Ensure month is between 01-12
      int month = int.parse(digitsOnly.substring(0, 2));
      if (month < 1) {
        digitsOnly = '01${digitsOnly.substring(2)}';
      } else if (month > 12) {
        digitsOnly = '12${digitsOnly.substring(2)}';
      }
    }
    
    // Format as MM/YY
    if (digitsOnly.isNotEmpty) {
      formatted += digitsOnly.substring(0, min(2, digitsOnly.length));
      
      if (digitsOnly.length > 2) {
        formatted += '/${digitsOnly.substring(2, min(4, digitsOnly.length))}';
      } else if (digitsOnly.length == 2) {
        formatted += '/';
      }
    }
    
    // Validate expiration date against current date
    _isExpirationValid = false;
    if (digitsOnly.length == 4) {
      int currentYear = DateTime.now().year % 100;
      int currentMonth = DateTime.now().month;
      
      int inputMonth = int.parse(digitsOnly.substring(0, 2));
      int inputYear = int.parse(digitsOnly.substring(2, 4));
      
      // Check if date is in the future
      if ((inputYear > currentYear) || 
          (inputYear == currentYear && inputMonth >= currentMonth)) {
        _isExpirationValid = true;
      }
    }
    
    // Update the text field with formatted text
    _expirationController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  // Helper function for min (since Dart doesn't have a built-in min function for ints)
  int min(int a, int b) {
    return a < b ? a : b;
  }

  // Validate all fields
  bool isFormValid() {
    return _isCardNumberValid && _isExpirationValid && 
           _isCvvValid && _isCardNameValid;
  }

  @override
  Widget build(BuildContext context) {
    // Define payment options
    final List<Map<String, dynamic>> paymentOptions = [
      {
        'value': 0,
        'title': 'Debit / Credit Card',
        'icon': ImageAssets.cardIcon,
      },
      {
        'value': 1,
        'title': 'Wallet',
        'icon': ImageAssets.walletIcon,
      },
    ];

    // Define summary items
    final List<Map<String, String>> summaryItems = [
      {'title': '5 nights × 800', 'value': '4000 SAR'},
      {'title': '2 Person × 800', 'value': '4000 SAR'},
      {'title': 'Vat', 'value': '0 SAR'},
    ];

    // Card details form widget
    final cardDetailsForm = CardDetailsFormWidget(
      cardNumberController: _cardNumberController,
      cardNameController: _cardNameController,
      expirationController: _expirationController,
      cvvController: _cvvController,
      saveData: _saveData,
      onCardNumberChanged: (value) {
        setState(() {
          String formatted = formatCardNumber(value);
          _cardNumberController.value = TextEditingValue(
            text: formatted,
            selection: TextSelection.collapsed(offset: formatted.length),
          );
        });
      },
      onCardNameChanged: (value) {
        setState(() {
          _isCardNameValid = value.trim().length > 2;
        });
      },
      onExpirationChanged: (value) {
        handleExpirationInput(value);
      },
      onCvvChanged: (value) {
        setState(() {
          _isCvvValid = value.length == 3;
        });
      },
      onSaveDataToggle: () {
        setState(() {
          _saveData = !_saveData;
        });
      },
      isFormValid: isFormValid(),
      onAddButtonPressed: () {
        // Save card details logic
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Card details added successfully"),
            backgroundColor: Colors.green,
          ),
        );
      },
    );

    // Promo code input widget
    final promoCodeInput = PromoCodeInputWidget(
      isApplied: true,
      controller: _promoCodeController,
      buttonText: "Apply",
      hintText: "MD1234",
      onApplyPressed: () {
        // Apply promo code logic
      },
    );

    // Discount row widget
    final discountRow = DiscountRowWidget(
      discountText: "After Discount",
      savedAmount: "(You Saved 100 SAR)",
      finalPrice: "900 SAR",
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: PaymentMethodScreenContent(
        selectedPaymentMethod: selectedPaymentMethod,
        onPaymentMethodChanged: (value) {
          setState(() {
            selectedPaymentMethod = value;
          });
        },
        paymentOptions: paymentOptions,
        cardDetailsForm: cardDetailsForm,
        summaryItems: summaryItems,
        promoCodeInput: promoCodeInput,
        discountRow: discountRow,
        showDiscount: true,
        onConfirmPayment: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfirmedPaymentScreen(),
            ),
          );
        },
      ),
    );
  }
}
