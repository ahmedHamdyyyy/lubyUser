// ignore_for_file: unused_local_variable, curly_braces_in_flow_control_structures
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luby2/core/localization/l10n_ext.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/widget/helper.dart';
import 'all_wideget_bank_card.dart';
// import 'package:fondok/core/widget/widgets.dart';
import 'bank_cards2_screen.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _cardNumberController = TextEditingController();
  final _cardNameController = TextEditingController();
  final _expirationController = TextEditingController();
  final _cvvController = TextEditingController();
  String _rawCardNumber = '';

  bool _saveData = false;
  bool _isCardNumberValid = false;
  bool _isExpirationValid = false;
  bool _isCvvValid = false;
  bool _isCardNameValid = false;

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
      if ((inputYear > currentYear) || (inputYear == currentYear && inputMonth >= currentMonth)) {
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
    return _isCardNumberValid && _isExpirationValid && _isCvvValid && _isCardNameValid;
  }

  // Handle card number changes
  void _handleCardNumberChanged(String value) {
    setState(() {
      String formatted = formatCardNumber(value);
      _cardNumberController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
      _isCardNumberValid = _rawCardNumber.length == 16;
    });
  }

  // Handle card name changes
  void _handleCardNameChanged(String value) {
    setState(() {
      _isCardNameValid = value.trim().length > 2;
    });
  }

  // Handle CVV changes
  void _handleCvvChanged(String value) {
    setState(() {
      _isCvvValid = value.length == 3;
    });
  }

  // Handle add button press
  void _handleAddPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const SavedCardsScreen()));

    // Show success message
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(context.l10n.cardDetailsAddedSuccessfully), backgroundColor: Colors.green));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarPop(context, context.l10n.addCardTitle, AppColors.primaryTextColor),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: CardFormWidget(
          cardNumberController: _cardNumberController,
          cardNameController: _cardNameController,
          expirationController: _expirationController,
          cvvController: _cvvController,
          saveData: _saveData,
          isFormValid: isFormValid(),
          onCardNumberChanged: _handleCardNumberChanged,
          onCardNameChanged: _handleCardNameChanged,
          onExpirationChanged: handleExpirationInput,
          onCvvChanged: _handleCvvChanged,
          onSaveDataToggle: (value) {
            setState(() {
              _saveData = value;
            });
          },
          onAddPressed: _handleAddPressed,
          cardNumberFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(16)],
          expirationFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
          cvvFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
        ),
      ),
    );
  }
}
