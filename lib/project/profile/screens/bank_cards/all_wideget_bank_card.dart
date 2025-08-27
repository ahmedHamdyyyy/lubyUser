import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/images/image_assets.dart';

// Card Details Title Widget
class CardDetailsTitleWidget extends StatelessWidget {
  const CardDetailsTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Card details",
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryColor,
      ),
    );
  }
}

// Input Field Widget
class CardInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final int maxLength;
  final Function(String)? onChanged;
  final bool obscureText;
  final List<TextInputFormatter>? formatters;

  const CardInputField({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    required this.keyboardType,
    required this.maxLength,
    this.onChanged,
    this.obscureText = false,
    this.formatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.secondTextColor,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            style: const TextStyle(
              color: AppColors.grayTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
            inputFormatters: formatters ??
                [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(maxLength),
                ],
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                color: const Color(0xFFCBCBCB),
              ),
              filled: true,
              fillColor: Colors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}

// Save Data Checkbox Widget
class SaveDataCheckbox extends StatelessWidget {
  final bool saveData;
  final Function(bool) onToggle;

  const SaveDataCheckbox({
    super.key,
    required this.saveData,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => onToggle(!saveData),
          child: saveData
              ? SvgPicture.asset(ImageAssets.cracalBlack)
              : SvgPicture.asset(ImageAssets.cracalWhite),
        ),
        Text(
          "  Save data when paying later",
          style: GoogleFonts.poppins(
            color: AppColors.secondTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

// Add Card Button Widget
class AddCardButton extends StatelessWidget {
  final bool isFormValid;
  final VoidCallback onPressed;

  const AddCardButton({
    super.key,
    required this.isFormValid,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isFormValid
              ? AppColors.primaryColor
              : AppColors.primaryColor.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: isFormValid ? onPressed : null,
        child: const Text(
          "Add",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}

// Card Form Widget
class CardFormWidget extends StatelessWidget {
  final TextEditingController cardNumberController;
  final TextEditingController cardNameController;
  final TextEditingController expirationController;
  final TextEditingController cvvController;
  final bool saveData;
  final bool isFormValid;
  final Function(String) onCardNumberChanged;
  final Function(String) onCardNameChanged;
  final Function(String) onExpirationChanged;
  final Function(String) onCvvChanged;
  final Function(bool) onSaveDataToggle;
  final VoidCallback onAddPressed;
  final List<TextInputFormatter>? cardNumberFormatters;
  final List<TextInputFormatter>? expirationFormatters;
  final List<TextInputFormatter>? cvvFormatters;

  const CardFormWidget({
    super.key,
    required this.cardNumberController,
    required this.cardNameController,
    required this.expirationController,
    required this.cvvController,
    required this.saveData,
    required this.isFormValid,
    required this.onCardNumberChanged,
    required this.onCardNameChanged,
    required this.onExpirationChanged,
    required this.onCvvChanged,
    required this.onSaveDataToggle,
    required this.onAddPressed,
    this.cardNumberFormatters,
    this.expirationFormatters,
    this.cvvFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CardDetailsTitleWidget(),
          const SizedBox(height: 20),
          CardInputField(
            label: "Card Number",
            controller: cardNumberController,
            hint: "0000 0000 0000 0000",
            keyboardType: TextInputType.number,
            maxLength: 19,
            onChanged: onCardNumberChanged,
            formatters: cardNumberFormatters,
          ),
          const SizedBox(height: 10),
          CardInputField(
            label: "Card Name",
            controller: cardNameController,
            hint: "Cardholder Name",
            formatters: [
              FilteringTextInputFormatter.singleLineFormatter,
              LengthLimitingTextInputFormatter(50),
            ],
            keyboardType: TextInputType.text,
            maxLength: 50,
            onChanged: onCardNameChanged,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: CardInputField(
                  label: "Expiration Date",
                  controller: expirationController,
                  hint: "MM/YY",
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  onChanged: onExpirationChanged,
                  formatters: expirationFormatters,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CardInputField(
                  label: "CVV",
                  controller: cvvController,
                  hint: "***",
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  onChanged: onCvvChanged,
                  obscureText: true,
                  formatters: cvvFormatters,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SaveDataCheckbox(
            saveData: saveData,
            onToggle: onSaveDataToggle,
          ),
          const SizedBox(height: 20),
          AddCardButton(
            isFormValid: isFormValid,
            onPressed: onAddPressed,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// Helper function to format card number with spaces
String formatCardNumber(String input) {
  // Remove all non-digit characters
  String cleanInput = input.replaceAll(RegExp(r'\D'), '');

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

// Helper function to find the minimum of two integers
int min(int a, int b) {
  return a < b ? a : b;
}

// Bank Cards Screen Title Widget
class BankCardsTitleWidget extends StatelessWidget {
  const BankCardsTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Bank Cards",
      style: TextStyle(
        fontFamily: 'Poppins',
        color: AppColors.primaryTextColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

// No Cards Widget
class NoCardsWidget extends StatelessWidget {
  const NoCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        Center(
          child: SvgPicture.asset(ImageAssets.card2, height: 150),
        ),
        const SizedBox(height: 20),
        const Text(
          "You have not added any bank card yet",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: AppColors.primaryTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// Add Card Button Widget for Bank Cards Screen
class AddCardButtonLarge extends StatelessWidget {
  final VoidCallback onPressed;

  const AddCardButtonLarge({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 15),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: const Text(
        "Add Card",
        style: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

// Bank Cards Screen Content Widget
class BankCardsScreenContent extends StatelessWidget {
  final VoidCallback onAddCardPressed;

  const BankCardsScreenContent({
    super.key,
    required this.onAddCardPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BankCardsTitleWidget(),
          const SizedBox(height: 50),
          const NoCardsWidget(),
          const SizedBox(height: 30),
          AddCardButtonLarge(onPressed: onAddCardPressed),
        ],
      ),
    );
  }
}

// Saved Cards Title Widget
class SavedCardsTitleWidget extends StatelessWidget {
  const SavedCardsTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Save Cards",
      style: TextStyle(
        color: AppColors.primaryTextColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      ),
    );
  }
}

// Separator Line Widget
class SeparatorLine extends StatelessWidget {
  const SeparatorLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        right: 10,
        left: 10,
      ),
      child: Container(
        height: 1,
        width: 50,
        color: AppColors.primaryTextColor,
      ),
    );
  }
}

// Card Item Widget
class SavedCardItem extends StatelessWidget {
  final bool isChecked;
  final Function(bool) onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final String cardName;
  final String cardNumber;

  const SavedCardItem({
    super.key,
    required this.isChecked,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
    this.cardName = "Card Name",
    this.cardNumber = "Card number ending with 5678",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => onToggle(!isChecked),
                child: isChecked
                    ? SvgPicture.asset(
                        ImageAssets.cracalWhite,
                        height: 20,
                        width: 20,
                      )
                    : SvgPicture.asset(
                        ImageAssets.cracalBlack,
                        height: 20,
                        width: 20,
                      ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  "Use this card to pay",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryTextColor,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              InkWell(
                onTap: onEdit,
                child: SvgPicture.asset(
                  ImageAssets.editIcon,
                  height: 25,
                  width: 25,
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: onDelete,
                child: SvgPicture.asset(
                  ImageAssets.deleteIcon,
                  height: 25,
                  width: 25,
                ),
              ),
            ],
          ),
          const SeparatorLine(),
          const SizedBox(height: 10),
          Text(
            cardName,
            style: const TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            cardNumber,
            style: const TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}

// Add New Card Button Widget
class AddNewCardButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddNewCardButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: onPressed,
      child: const Text(
        "Add New Card",
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

// Saved Cards Screen Content Widget
class SavedCardsScreenContent extends StatelessWidget {
  final bool isFirstCardChecked;
  final bool isSecondCardChecked;
  final Function(bool) onFirstCardToggle;
  final Function(bool) onSecondCardToggle;
  final VoidCallback onFirstCardEdit;
  final VoidCallback onFirstCardDelete;
  final VoidCallback onSecondCardEdit;
  final VoidCallback onSecondCardDelete;
  final VoidCallback onAddNewCard;

  const SavedCardsScreenContent({
    super.key,
    required this.isFirstCardChecked,
    required this.isSecondCardChecked,
    required this.onFirstCardToggle,
    required this.onSecondCardToggle,
    required this.onFirstCardEdit,
    required this.onFirstCardDelete,
    required this.onSecondCardEdit,
    required this.onSecondCardDelete,
    required this.onAddNewCard,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SavedCardsTitleWidget(),
          const SizedBox(height: 20),
          SavedCardItem(
            isChecked: isFirstCardChecked,
            onToggle: onFirstCardToggle,
            onEdit: onFirstCardEdit,
            onDelete: onFirstCardDelete,
          ),
          SavedCardItem(
            isChecked: isSecondCardChecked,
            onToggle: onSecondCardToggle,
            onEdit: onSecondCardEdit,
            onDelete: onSecondCardDelete,
          ),
          const SizedBox(height: 20),
          AddNewCardButton(onPressed: onAddNewCard),
        ],
      ),
    );
  }
}

// Delete Card Dialog Title Widget
class DeleteCardDialogTitle extends StatelessWidget {
  const DeleteCardDialogTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Delete Card",
        style: TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins',
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}

// Delete Card Dialog Content Widget
class DeleteCardDialogContent extends StatelessWidget {
  const DeleteCardDialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Are you sure about deleting your Card ?",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: AppColors.primaryTextColor,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins',
      ),
    );
  }
}

// Delete Card Dialog Confirm Button
class DeleteCardConfirmButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DeleteCardConfirmButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        minimumSize: const Size(100, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text("Yes",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          )),
    );
  }
}

// Delete Card Dialog Cancel Button
class DeleteCardCancelButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DeleteCardCancelButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(100, 40),
        side: const BorderSide(color: AppColors.primaryTextColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text(
        "Cancel",
        style: TextStyle(
          fontSize: 16,
          color: AppColors.primaryTextColor,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}

// Delete Card Dialog Widget
class DeleteCardDialogWidget extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const DeleteCardDialogWidget({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const DeleteCardDialogTitle(),
      content: const DeleteCardDialogContent(),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        DeleteCardConfirmButton(onPressed: onConfirm),
        DeleteCardCancelButton(onPressed: onCancel),
      ],
    );
  }
}

// Edit Card Button Widget
class EditCardButton extends StatelessWidget {
  final bool isFormValid;
  final VoidCallback onPressed;

  const EditCardButton({
    super.key,
    required this.isFormValid,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isFormValid
              ? AppColors.primaryColor
              : AppColors.primaryColor.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: isFormValid ? onPressed : null,
        child: const Text(
          "Save",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

// Card Edit Form Widget
class CardEditFormWidget extends StatelessWidget {
  final TextEditingController cardNumberController;
  final TextEditingController cardNameController;
  final TextEditingController expirationController;
  final TextEditingController cvvController;
  final bool saveData;
  final bool isFormValid;
  final Function(String) onCardNumberChanged;
  final Function(String) onCardNameChanged;
  final Function(String) onExpirationChanged;
  final Function(String) onCvvChanged;
  final Function(bool) onSaveDataToggle;
  final VoidCallback onSavePressed;
  final List<TextInputFormatter>? cardNumberFormatters;
  final List<TextInputFormatter>? expirationFormatters;
  final List<TextInputFormatter>? cvvFormatters;

  const CardEditFormWidget({
    super.key,
    required this.cardNumberController,
    required this.cardNameController,
    required this.expirationController,
    required this.cvvController,
    required this.saveData,
    required this.isFormValid,
    required this.onCardNumberChanged,
    required this.onCardNameChanged,
    required this.onExpirationChanged,
    required this.onCvvChanged,
    required this.onSaveDataToggle,
    required this.onSavePressed,
    this.cardNumberFormatters,
    this.expirationFormatters,
    this.cvvFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CardDetailsTitleWidget(),
          const SizedBox(height: 20),
          CardInputField(
            label: "Card Number",
            controller: cardNumberController,
            hint: "0000 0000 0000 0000",
            keyboardType: TextInputType.number,
            maxLength: 19,
            onChanged: onCardNumberChanged,
            formatters: cardNumberFormatters,
          ),
          const SizedBox(height: 10),
          CardInputField(
            label: "Card Name",
            controller: cardNameController,
            hint: "Cardholder Name",
            keyboardType: TextInputType.text,
            maxLength: 50,
            onChanged: onCardNameChanged,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: CardInputField(
                  label: "Expiration Date",
                  controller: expirationController,
                  hint: "MM/YY",
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  onChanged: onExpirationChanged,
                  formatters: expirationFormatters,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CardInputField(
                  label: "CVV",
                  controller: cvvController,
                  hint: "***",
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  onChanged: onCvvChanged,
                  obscureText: true,
                  formatters: cvvFormatters,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SaveDataCheckbox(
            saveData: saveData,
            onToggle: onSaveDataToggle,
          ),
          const SizedBox(height: 20),
          EditCardButton(
            isFormValid: isFormValid,
            onPressed: onSavePressed,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
