// // ignore_for_file: library_private_types_in_public_api, deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../../../../config/images/image_assets.dart';
// import '../../../../core/localization/l10n_ext.dart';
// import '../../../config/colors/colors.dart';
// import '../../models/reversation.dart';
// import 'all_widget__complete_reservation_and_payment.dart';
// import 'confirm_payment.dart';

// class PaymentMethodScreen extends StatefulWidget {
//   const PaymentMethodScreen({super.key, required this.reservation});
//   final ReservationModel reservation;
//   @override
//   _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
// }

// class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
//   final _expirationController = TextEditingController(), _cvvController = TextEditingController();
//   final _cardNameController = TextEditingController(), _promoCodeController = TextEditingController();
//   final _cardNumberController = TextEditingController();
//   bool _isCardNumberValid = false, _isExpirationValid = false, _saveData = false;
//   bool _isCvvValid = false, _isCardNameValid = false;
//   String _rawCardNumber = '', vendorId = '';
//   int selectedPaymentMethod = 0;

//   @override
//   void dispose() {
//     _cardNumberController.dispose();
//     _expirationController.dispose();
//     _cvvController.dispose();
//     _cardNameController.dispose();
//     _promoCodeController.dispose();
//     super.dispose();
//   }

//   // Format the card number with spaces after every 4 digits (visible during input)
//   String formatCardNumber(String input) {
//     // Remove all non-digit characters
//     String cleanInput = input.replaceAll(RegExp(r'\D'), '');
//     _rawCardNumber = cleanInput;

//     // Check if card number is valid (simple length check)
//     _isCardNumberValid = cleanInput.length == 16;

//     // Format with spaces for display
//     StringBuffer buffer = StringBuffer();
//     for (int i = 0; i < cleanInput.length; i++) {
//       if (i > 0 && i % 4 == 0) {
//         buffer.write(' ');
//       }
//       buffer.write(cleanInput[i]);
//     }
//     return buffer.toString();
//   }

//   // Format visible card number with masking (● for first 12 digits)
//   String obscureCardNumber(String formattedInput) {
//     if (_rawCardNumber.length <= 4) return formattedInput;

//     // Create a masked version showing only last 4 digits
//     String lastFourDigits = _rawCardNumber.substring(_rawCardNumber.length - 4);
//     String maskedPart = "●●●● ●●●● ●●●● ";

//     return maskedPart + lastFourDigits;
//   }

//   // Validate and format expiration date (MM/YY)
//   void handleExpirationInput(String value) {
//     // Remove any non-digit characters
//     String digitsOnly = value.replaceAll(RegExp(r'\D'), '');

//     if (digitsOnly.isEmpty) {
//       _expirationController.text = '';
//       _isExpirationValid = false;
//       return;
//     }

//     // Handle the formatting logic for MM/YY
//     String formatted = '';

//     if (digitsOnly.isNotEmpty) {
//       // First digit of month can only be 0 or 1
//       int firstDigit = int.parse(digitsOnly[0]);
//       if (firstDigit > 1) {
//         digitsOnly = '0$digitsOnly';
//       }
//     }

//     if (digitsOnly.length >= 2) {
//       // Ensure month is between 01-12
//       int month = int.parse(digitsOnly.substring(0, 2));
//       if (month < 1) {
//         digitsOnly = '01${digitsOnly.substring(2)}';
//       } else if (month > 12) {
//         digitsOnly = '12${digitsOnly.substring(2)}';
//       }
//     }

//     // Format as MM/YY
//     if (digitsOnly.isNotEmpty) {
//       formatted += digitsOnly.substring(0, min(2, digitsOnly.length));

//       if (digitsOnly.length > 2) {
//         formatted += '/${digitsOnly.substring(2, min(4, digitsOnly.length))}';
//       } else if (digitsOnly.length == 2) {
//         formatted += '/';
//       }
//     }

//     // Validate expiration date against current date
//     _isExpirationValid = false;
//     if (digitsOnly.length == 4) {
//       int currentYear = DateTime.now().year % 100;
//       int currentMonth = DateTime.now().month;

//       int inputMonth = int.parse(digitsOnly.substring(0, 2));
//       int inputYear = int.parse(digitsOnly.substring(2, 4));

//       // Check if date is in the future
//       if ((inputYear > currentYear) || (inputYear == currentYear && inputMonth >= currentMonth)) {
//         _isExpirationValid = true;
//       }
//     }

//     // Update the text field with formatted text
//     _expirationController.value = TextEditingValue(
//       text: formatted,
//       selection: TextSelection.collapsed(offset: formatted.length),
//     );
//   }

//   // Helper function for min (since Dart doesn't have a built-in min function for ints)
//   int min(int a, int b) {
//     return a < b ? a : b;
//   }

//   // Validate all fields
//   bool isFormValid() {
//     return _isCardNumberValid && _isExpirationValid && _isCvvValid && _isCardNameValid;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Define payment options
//     final List<Map<String, dynamic>> paymentOptions = [
//       {'value': 0, 'title': context.l10n.debitCreditCard, 'icon': ImageAssets.cardIcon},
//       {'value': 1, 'title': context.l10n.wallet, 'icon': ImageAssets.walletIcon},
//     ];

//     // Define summary items
//     final List<Map<String, String>> summaryItems = [
//       {'title': '5 nights × 800', 'value': '4000 SAR'},
//       {'title': '2 Person × 800', 'value': '4000 SAR'},
//       {'title': 'Vat', 'value': '0 SAR'},
//     ];

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 50),
//             Row(
//               children: [
//                 InkWell(
//                   onTap: () => Navigator.pop(context),
//                   child: Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon),
//                 ),
//                 const SizedBox(width: 8),
//                 Text(
//                   context.l10n.paymentMethodTitle,
//                   style: GoogleFonts.poppins(color: AppColors.grayTextColor, fontWeight: FontWeight.w500, fontSize: 14),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 22),
//             Text(
//               context.l10n.paymentMethodTitle,
//               style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.secondTextColor),
//             ),
//             const SizedBox(height: 10),
//             ...paymentOptions.map(
//               (option) => GestureDetector(
//                 onTap: () => (value) => setState(() => selectedPaymentMethod = value),
//                 child: Container(
//                   padding: const EdgeInsets.all(15),
//                   margin: const EdgeInsets.symmetric(vertical: 5),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: AppColors.primaryColor),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     children: [
//                       option['value'] == selectedPaymentMethod
//                           ? SvgPicture.asset(ImageAssets.cracalBlack)
//                           : SvgPicture.asset(ImageAssets.cracalWhite),
//                       const SizedBox(width: 10),
//                       Text(
//                         option['title'],
//                         style: GoogleFonts.poppins(
//                           color: AppColors.secondTextColor,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       const Spacer(),
//                       SvgPicture.asset(option['icon'], color: AppColors.primaryColor),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             if (selectedPaymentMethod == 0)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Divider()),
//                   const SizedBox(height: 10),
//                   Text(
//                     context.l10n.cardDetails,
//                     style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
//                   ),
//                   const SizedBox(height: 20),

//                   // Card Number
//                   InputFieldWidget(
//                     label: context.l10n.cardNumber,
//                     controller: _cardNumberController,
//                     hint: context.l10n.cardNumberHint,
//                     keyboardType: TextInputType.number,
//                     maxLength: 19,
//                     onChanged:
//                         (value) => setState(() {
//                           String formatted = formatCardNumber(value);
//                           _cardNumberController.value = TextEditingValue(
//                             text: formatted,
//                             selection: TextSelection.collapsed(offset: formatted.length),
//                           );
//                         }),
//                     formatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(16)],
//                   ),

//                   const SizedBox(height: 10),

//                   // Card Name
//                   InputFieldWidget(
//                     label: context.l10n.cardName,
//                     controller: _cardNameController,
//                     hint: context.l10n.cardholderName,
//                     keyboardType: TextInputType.text,
//                     maxLength: 50,
//                     onChanged: (value) => setState(() => _isCardNameValid = value.trim().length > 2),
//                     formatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))],
//                   ),

//                   const SizedBox(height: 10),

//                   // Expiration Date and CVV
//                   Row(
//                     children: [
//                       Expanded(
//                         child: InputFieldWidget(
//                           label: context.l10n.expirationDate,
//                           controller: _expirationController,
//                           hint: context.l10n.expirationHint,
//                           keyboardType: TextInputType.number,
//                           maxLength: 5,
//                           onChanged: (value) => handleExpirationInput(value),
//                           formatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: InputFieldWidget(
//                           label: context.l10n.cvv,
//                           controller: _cvvController,
//                           hint: "***",
//                           keyboardType: TextInputType.number,
//                           maxLength: 3,
//                           onChanged: (value) => setState(() => _isCvvValid = value.length == 3),
//                           obscureText: true,
//                           formatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       InkWell(
//                         onTap: () => setState(() => _saveData = !_saveData),
//                         child:
//                             _saveData
//                                 ? SvgPicture.asset(ImageAssets.cracalBlack)
//                                 : SvgPicture.asset(ImageAssets.cracalWhite),
//                       ),
//                       Text(
//                         "  ${context.l10n.saveDataWhenPayLater}",
//                         style: GoogleFonts.poppins(
//                           color: AppColors.secondTextColor,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   ActionButtonWidget(
//                     text: context.l10n.addLabel,
//                     onPressed: () {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text(context.l10n.cardDetailsAddedSuccessfully), backgroundColor: Colors.green),
//                       );
//                     },
//                     isEnabled: isFormValid(),
//                     fontSize: 18,
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             Text(
//               context.l10n.summaryTitle,
//               style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.secondTextColor),
//             ),
//             const SizedBox(height: 10),
//             ...summaryItems.map((item) => SummaryRowWidget(title: item['title']!, value: item['value']!)),
//             const Divider(),
//             PromoCodeInputWidget(
//               isApplied: true,
//               controller: _promoCodeController,
//               buttonText: context.l10n.commonApply,
//               hintText: context.l10n.promoCodePlaceholder,
//               onApplyPressed: () {
//                 // Apply promo code logic
//               },
//             ),
//             const SizedBox(height: 10),
//             SummaryRowWidget(title: context.l10n.commonTotal, value: "1000 SAR"),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 5),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     context.l10n.afterDiscount,
//                     style: GoogleFonts.poppins(color: AppColors.primaryColor, fontSize: 14, fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     context.l10n.youSavedAmount('100 SAR'),
//                     style: GoogleFonts.poppins(color: AppColors.secondTextColor, fontSize: 12, fontWeight: FontWeight.w600),
//                   ),
//                   const Spacer(),
//                   Text(
//                     "900 SAR",
//                     style: GoogleFonts.poppins(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             ActionButtonWidget(
//               text: context.l10n.confirmPayment,
//               fontSize: 16,
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmedPaymentScreen(vendorId: vendorId)));
//               },
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
