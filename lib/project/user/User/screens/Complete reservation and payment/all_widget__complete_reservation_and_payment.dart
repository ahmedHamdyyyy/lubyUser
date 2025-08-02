import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/images/image_assets.dart';

// ------------------------ Confirmed Payment Screen Widgets ------------------------

// Reservation Item Widget
class ReservationItemWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String hostName;
  final VoidCallback onMessageTap;

  const ReservationItemWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.hostName,
    required this.onMessageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(imagePath),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Hosted by\n",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondTextColor,
                          ),
                        ),
                        TextSpan(
                          text: hostName,
                          style: GoogleFonts.poppins(
                            color: AppColors.grayTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: onMessageTap,
              child: SvgPicture.asset(
                ImageAssets.messages,
                // ignore: deprecated_member_use
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Summary Row Widget
class SummaryRowWidget extends StatelessWidget {
  final String title;
  final String value;

  const SummaryRowWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

// Download Summary Widget
class DownloadSummaryWidget extends StatelessWidget {
  const DownloadSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Row(
        children: [
          Image.asset(
            ImageAssets.pdfIcon,
            width: 30,
            height: 30,
          ),
          const SizedBox(width: 10),
          Text(
            "View reservation summary",
            style: GoogleFonts.poppins(
              color: AppColors.secondTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            ImageAssets.arrowDown,
            
            // ignore: deprecated_member_use
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}

// Disclaimer Widget
class DisclaimerWidget extends StatelessWidget {
  const DisclaimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Lobby disclaims responsibility for any financial\ntransfers outside the platform.\nIf there is a deposit or a balance, it is paid\nbefore you enter.",
      style: GoogleFonts.poppins(
        color: AppColors.secondTextColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

// Done Button Widget
class DoneButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const DoneButtonWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          "Done",
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

// Confirmed Payment Screen Content Widget
class ConfirmedPaymentScreenContent extends StatelessWidget {
  final String reservationNumber;
  final List<Map<String, String>> reservationItems;
  final List<Map<String, String>> summaryItems;
  final VoidCallback onDonePressed;
  final Function(String, String) onMessagePressed;

  const ConfirmedPaymentScreenContent({
    super.key,
    required this.reservationNumber,
    required this.reservationItems,
    required this.summaryItems,
    required this.onDonePressed,
    required this.onMessagePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Confirmed reservation number $reservationNumber",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.secondTextColor,
            ),
          ),
          const SizedBox(height: 10),
          ...reservationItems.map(
            (item) => ReservationItemWidget(
              imagePath: item['imagePath']!,
              title: item['title']!,
              hostName: item['hostName']!,
              onMessageTap: () =>
                  onMessagePressed(item['hostName']!, item['imagePath']!),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Summary",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          ...summaryItems.map(
            (item) => SummaryRowWidget(
              title: item['title']!,
              value: item['value']!,
            ),
          ),
          const Divider(),
          const DownloadSummaryWidget(),
          const Divider(),
          const SizedBox(height: 10),
          const DisclaimerWidget(),
          const SizedBox(height: 20),
          DoneButtonWidget(onPressed: onDonePressed),
        ],
      ),
    );
  }
}

// ------------------------ Login Screen Widgets ------------------------

// App Logo Widget
class AppLogoWidget extends StatelessWidget {
  final double size;

  const AppLogoWidget({
    super.key,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo1.png',
      color: AppColors.primary,
      width: size,
      height: size,
    );
  }
}

// Welcome Title Widget
class WelcomeTitleWidget extends StatelessWidget {
  final double fontSize;

  const WelcomeTitleWidget({
    super.key,
    this.fontSize = 22,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Welcome !",
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
      ),
    );
  }
}

// Welcome Subtitle Widget
class WelcomeSubtitleWidget extends StatelessWidget {
  final double fontSize;

  const WelcomeSubtitleWidget({
    super.key,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Please enter your mobile number to create an account or log in.",
      textAlign: TextAlign.start,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        color: Colors.black54,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

// Country Code Picker Widget
class CountryCodePickerWidget extends StatelessWidget {
  const CountryCodePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/egypt_flag.png',
            width: 24,
          ),
          const Text("+02"),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}

// Phone Number Field Widget
class PhoneNumberFieldWidget extends StatelessWidget {
  final TextEditingController controller;

  const PhoneNumberFieldWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: "0123456789",
        hintStyle: GoogleFonts.poppins(
          color: const Color(0xFFCBCBCB),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

// Continue Button Widget
class ContinueButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final double fontSize;

  const ContinueButtonWidget({
    super.key,
    required this.onPressed,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          "Continue",
          style: GoogleFonts.poppins(
            fontSize: fontSize,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

// Social Button Widget
class SocialButtonWidget extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onPressed;

  const SocialButtonWidget({
    super.key,
    required this.imagePath,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: const BorderSide(color: AppColors.primary),
          ),
          onPressed: onPressed,
          child: Row(
            children: [
              Image.asset(
                imagePath,
                width: 22,
                height: 22,
              ),
              const SizedBox(width: 20),
              Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color(0xFF414141),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Login Screen Content Widget
class LoginScreenContent extends StatelessWidget {
  final TextEditingController phoneController;
  final VoidCallback onContinuePressed;
  final VoidCallback onEmailPressed;
  final VoidCallback onGooglePressed;
  final VoidCallback onFacebookPressed;
  final bool isLargeScreen;

  const LoginScreenContent({
    super.key,
    required this.phoneController,
    required this.onContinuePressed,
    required this.onEmailPressed,
    required this.onGooglePressed,
    required this.onFacebookPressed,
    required this.isLargeScreen,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              isLargeScreen ? MediaQuery.of(context).size.width * 0.2 : 20,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            const Center(child: AppLogoWidget()),
            const SizedBox(height: 20),

            // Welcome text
            WelcomeTitleWidget(fontSize: isLargeScreen ? 28 : 22),
            const SizedBox(height: 10),

            // Subtitle
            WelcomeSubtitleWidget(fontSize: isLargeScreen ? 18 : 14),
            const SizedBox(height: 20),

            // Phone number input
            Row(
              children: [
                const CountryCodePickerWidget(),
                const SizedBox(width: 10),
                Expanded(
                    child: PhoneNumberFieldWidget(controller: phoneController)),
              ],
            ),
            const SizedBox(height: 20),

            // Continue button
            ContinueButtonWidget(
              onPressed: onContinuePressed,
              fontSize: isLargeScreen ? 20 : 16,
            ),
            const SizedBox(height: 20),

            // "Or" text
            Center(
              child: Text(
                "or",
                style: GoogleFonts.poppins(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Social login buttons
            SocialButtonWidget(
              imagePath: 'assets/images/mail_flag.png',
              text: "Continue with E-mail",
              onPressed: onEmailPressed,
            ),
            SocialButtonWidget(
              imagePath: 'assets/images/google_flag.png',
              text: "Continue with Google",
              onPressed: onGooglePressed,
            ),
            SocialButtonWidget(
              imagePath: 'assets/images/facebook_flag.png',
              text: "Continue with Facebook",
              onPressed: onFacebookPressed,
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------ Payment Method Screen Widgets ------------------------

// Payment Option Widget
class PaymentOptionWidget extends StatelessWidget {
  final int value;
  final int selectedValue;
  final String title;
  final String icon;
  final Function(int) onTap;

  const PaymentOptionWidget({
    super.key,
    required this.value,
    required this.selectedValue,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            value == selectedValue
                ? SvgPicture.asset(ImageAssets.cracalBlack)
                : SvgPicture.asset(ImageAssets.cracalWhite),
            const SizedBox(width: 10),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: AppColors.secondTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            // ignore: deprecated_member_use
            SvgPicture.asset(icon, color: AppColors.primaryColor),
          ],
        ),
      ),
    );
  }
}

// Input Field Widget
class InputFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final int maxLength;
  final Function(String)? onChanged;
  final bool obscureText;
  final List<TextInputFormatter>? formatters;

  const InputFieldWidget({
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
        Text(label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: AppColors.secondTextColor,
              fontWeight: FontWeight.w400,
            )),
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
            style: GoogleFonts.poppins(
              color: AppColors.grayTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
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

// Save Card Data Widget
class SaveCardDataWidget extends StatelessWidget {
  final bool isSaved;
  final VoidCallback onTap;

  const SaveCardDataWidget({
    super.key,
    required this.isSaved,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: isSaved
              ? SvgPicture.asset(ImageAssets.cracalBlack)
              : SvgPicture.asset(ImageAssets.cracalWhite),
        ),
        Text("  Save data when paying later",
            style: GoogleFonts.poppins(
              color: AppColors.secondTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            )),
      ],
    );
  }
}

// Action Button Widget
class ActionButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isEnabled;
  final double fontSize;

  const ActionButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? AppColors.primaryColor
              // ignore: deprecated_member_use
              : AppColors.primaryColor.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: isEnabled ? onPressed : null,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: fontSize,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// Card Details Form Widget
class CardDetailsFormWidget extends StatelessWidget {
  final TextEditingController cardNumberController;
  final TextEditingController cardNameController;
  final TextEditingController expirationController;
  final TextEditingController cvvController;
  final bool saveData;
  final Function(String) onCardNumberChanged;
  final Function(String) onCardNameChanged;
  final Function(String) onExpirationChanged;
  final Function(String) onCvvChanged;
  final VoidCallback onSaveDataToggle;
  final bool isFormValid;
  final VoidCallback onAddButtonPressed;

  const CardDetailsFormWidget({
    super.key,
    required this.cardNumberController,
    required this.cardNameController,
    required this.expirationController,
    required this.cvvController,
    required this.saveData,
    required this.onCardNumberChanged,
    required this.onCardNameChanged,
    required this.onExpirationChanged,
    required this.onCvvChanged,
    required this.onSaveDataToggle,
    required this.isFormValid,
    required this.onAddButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        const SizedBox(height: 10),
        Text("Card details",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            )),
        const SizedBox(height: 20),

        // Card Number
        InputFieldWidget(
          label: "Card Number",
          controller: cardNumberController,
          hint: "0000 0000 0000 0000",
          keyboardType: TextInputType.number,
          maxLength: 19,
          onChanged: onCardNumberChanged,
          formatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
          ],
        ),

        const SizedBox(height: 10),

        // Card Name
        InputFieldWidget(
          label: "Card Name",
          controller: cardNameController,
          hint: "Cardholder Name",
          keyboardType: TextInputType.text,
          maxLength: 50,
          onChanged: onCardNameChanged,
          formatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
          ],
        ),

        const SizedBox(height: 10),

        // Expiration Date and CVV
        Row(
          children: [
            Expanded(
              child: InputFieldWidget(
                label: "Expiration Date",
                controller: expirationController,
                hint: "MM/YY",
                keyboardType: TextInputType.number,
                maxLength: 5,
                onChanged: onExpirationChanged,
                formatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InputFieldWidget(
                label: "CVV",
                controller: cvvController,
                hint: "***",
                keyboardType: TextInputType.number,
                maxLength: 3,
                onChanged: onCvvChanged,
                obscureText: true,
                formatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Save Data Checkbox
        SaveCardDataWidget(
          isSaved: saveData,
          onTap: onSaveDataToggle,
        ),

        const SizedBox(height: 20),

        // Add Button
        ActionButtonWidget(
          text: "Add",
          onPressed: onAddButtonPressed,
          isEnabled: isFormValid,
          fontSize: 18,
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

// Promo Code Input Widget
class PromoCodeInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String buttonText;
  final VoidCallback onApplyPressed;
  final bool isApplied;
  final String hintText;

  const PromoCodeInputWidget({
    super.key,
    required this.controller,
    required this.buttonText,
    required this.onApplyPressed,
    this.isApplied = false,
    this.hintText = "Enter promo code",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: InputBorder.none,
                hintStyle: GoogleFonts.poppins(
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: isApplied ? Colors.grey.shade200 : AppColors.primaryColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: TextButton(
              onPressed: onApplyPressed,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
              child: Text(
                buttonText,
                style: GoogleFonts.poppins(
                  color: isApplied ? AppColors.primaryColor : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Discount Row Widget
class DiscountRowWidget extends StatelessWidget {
  final String discountText;
  final String savedAmount;
  final String finalPrice;

  const DiscountRowWidget({
    super.key,
    required this.discountText,
    required this.savedAmount,
    required this.finalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            discountText,
            style: GoogleFonts.poppins(
              color: AppColors.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            savedAmount,
            style: GoogleFonts.poppins(
              color: AppColors.secondTextColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            finalPrice,
            style: GoogleFonts.poppins(
              color: AppColors.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// Payment Method Screen Content Widget
class PaymentMethodScreenContent extends StatelessWidget {
  final int selectedPaymentMethod;
  final Function(int) onPaymentMethodChanged;
  final List<Map<String, dynamic>> paymentOptions;
  final Widget cardDetailsForm;
  final List<Map<String, String>> summaryItems;
  final Widget promoCodeInput;
  final Widget discountRow;
  final VoidCallback onConfirmPayment;
  final bool showDiscount;

  const PaymentMethodScreenContent({
    super.key,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodChanged,
    required this.paymentOptions,
    required this.cardDetailsForm,
    required this.summaryItems,
    required this.promoCodeInput,
    required this.discountRow,
    required this.onConfirmPayment,
    this.showDiscount = false,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Row(
            children: [
              InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back_ios,
                      color: AppColors.grayColorIcon)),
              const SizedBox(width: 8),
              Text(
                "Payment Method",
                style: GoogleFonts.poppins(
                  color: AppColors.grayTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              )
            ],
          ),
          const SizedBox(height: 22),
          Text("Payment Method",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.secondTextColor,
              )),
          const SizedBox(height: 10),

          // Payment options
          ...paymentOptions.map(
            (option) => PaymentOptionWidget(
              value: option['value'],
              selectedValue: selectedPaymentMethod,
              title: option['title'],
              icon: option['icon'],
              onTap: onPaymentMethodChanged,
            ),
          ),

          // Card details form (conditionally shown)
          if (selectedPaymentMethod == 0) cardDetailsForm,

          // Summary section
          Text("Summary",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.secondTextColor,
              )),
          const SizedBox(height: 10),

          // Summary items
          ...summaryItems.map(
            (item) => SummaryRowWidget(
              title: item['title']!,
              value: item['value']!,
            ),
          ),

          const Divider(),

          // Promo code input
          promoCodeInput,

          const SizedBox(height: 10),

          // Total price
          const SummaryRowWidget(
            title: "Total",
            value: "1000 SAR",
          ),

          // Discount row (conditionally shown)
          if (showDiscount) discountRow,

          const SizedBox(height: 20),

          // Confirm payment button
          ActionButtonWidget(
            text: "Confirm Payment",
            onPressed: onConfirmPayment,
            fontSize: 16,
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// ------------------------ Summary Screen Widgets ------------------------

// Reserved Item Card Widget
class ReservedItemCardWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String location;
  final String dateDetails;
  final String price;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ReservedItemCardWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.location,
    required this.dateDetails,
    required this.price,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(10),
                        right: Radius.circular(10),
                      ),
                      child: Image.asset(
                        imagePath,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: AppColors.secondTextColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Text(
                            price,
                            style: GoogleFonts.poppins(
                              color: AppColors.secondTextColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        location,
                        style: GoogleFonts.poppins(
                          color: AppColors.grayTextColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        dateDetails,
                        style: GoogleFonts.poppins(
                          color: AppColors.grayTextColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Free cancellation before 27 October",
                  style: GoogleFonts.poppins(
                    color: AppColors.secondTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (onEdit != null)
                    InkWell(
                      onTap: onEdit,
                      child: SvgPicture.asset(ImageAssets.editIcon),
                    ),
                  const SizedBox(width: 10),
                  if (onDelete != null)
                    InkWell(
                      onTap: onDelete,
                      child: SvgPicture.asset(ImageAssets.deleteIcon),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

// Promo Code Success Message Widget
class PromoCodeSuccessMessageWidget extends StatelessWidget {
  final String message;

  const PromoCodeSuccessMessageWidget({
    super.key,
    this.message = "The promo code has been applied successfully",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        message,
        style: GoogleFonts.poppins(
          color: AppColors.primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

// Section Title Widget
class SectionTitleWidget extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;

  const SectionTitleWidget({
    super.key,
    required this.title,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: AppColors.secondTextColor,
      ),
    );
  }
}

// Summary Screen Content Widget
class SummaryScreenContent extends StatelessWidget {
  final List<Map<String, dynamic>> rentalItems;
  final List<Map<String, dynamic>> activityItems;
  final List<Map<String, String>> summaryItems;
  final Widget promoCodeInput;
  final bool showSuccessMessage;
  final String successMessage;
  final bool isApplied;
  final String discountText;
  final String savedAmount;
  final String finalPrice;
  final VoidCallback onPaymentMethodPressed;

  const SummaryScreenContent({
    super.key,
    required this.rentalItems,
    required this.activityItems,
    required this.summaryItems,
    required this.promoCodeInput,
    required this.showSuccessMessage,
    this.successMessage = "The promo code has been applied successfully",
    this.isApplied = false,
    this.discountText = "After Discount",
    this.savedAmount = "(You Saved 100 SAR)",
    this.finalPrice = "900 SAR",
    required this.onPaymentMethodPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Row(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child:
                    Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon),
              ),
              const SizedBox(width: 8),
              Text(
                "Summary",
                style: GoogleFonts.poppins(
                  color: AppColors.grayTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              )
            ],
          ),
          const SizedBox(height: 22),

          // Reserved items section
          const SectionTitleWidget(title: "Reserved items"),
          const SizedBox(height: 15),

          // Rental property section
          if (rentalItems.isNotEmpty) ...[
            const SectionTitleWidget(
              title: "Rental property",
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(height: 10),
            ...rentalItems.map(
              (item) => ReservedItemCardWidget(
                imagePath: item['imagePath'],
                title: item['title'],
                location: item['location'],
                dateDetails: item['dateDetails'],
                price: item['price'],
                onEdit: item['onEdit'],
                onDelete: item['onDelete'],
              ),
            ),
          ],

          // Tourist activities section
          if (activityItems.isNotEmpty) ...[
            const SectionTitleWidget(
              title: "Tourist Activities",
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(height: 10),
            ...activityItems.map(
              (item) => ReservedItemCardWidget(
                imagePath: item['imagePath'],
                title: item['title'],
                location: item['location'],
                dateDetails: item['dateDetails'],
                price: item['price'],
                onEdit: item['onEdit'],
                onDelete: item['onDelete'],
              ),
            ),
          ],

          const SizedBox(height: 20),

          // Summary section
          const SectionTitleWidget(title: "Summary"),
          const SizedBox(height: 10),

          // Summary items
          ...summaryItems.map(
            (item) => SummaryRowWidget(
              title: item['title']!,
              value: item['value']!,
            ),
          ),

          const Divider(),

          // Promo code section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              promoCodeInput,

              // Success message
              if (showSuccessMessage)
                PromoCodeSuccessMessageWidget(message: successMessage),

              const SizedBox(height: 20),

              // Total price
              const SummaryRowWidget(
                title: "Total",
                value: "1000 SAR",
              ),

              // Discount row
              if (isApplied)
                DiscountRowWidget(
                  discountText: discountText,
                  savedAmount: savedAmount,
                  finalPrice: finalPrice,
                ),

              const SizedBox(height: 20),

              // Payment method button
              ActionButtonWidget(
                text: "Payment Method",
                onPressed: onPaymentMethodPressed,
                fontSize: 18,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ],
      ),
    );
  }
}
