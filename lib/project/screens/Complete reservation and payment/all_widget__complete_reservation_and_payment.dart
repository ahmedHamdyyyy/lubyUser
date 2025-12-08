import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luby2/core/localization/l10n_ext.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/images/image_assets.dart';

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
            CircleAvatar(radius: 25, backgroundImage: AssetImage(imagePath)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 16)),
                  const SizedBox(height: 5),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${context.l10n.hostedBy}\n',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: AppColors.secondTextColor),
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

  const SummaryRowWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400)),
          Text(value, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}

// ------------------------ Login Screen Widgets ------------------------

// App Logo Widget
class AppLogoWidget extends StatelessWidget {
  final double size;

  const AppLogoWidget({super.key, this.size = 120});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/logo1.png', color: AppColors.primary, width: size, height: size);
  }
}

// Welcome Title Widget
class WelcomeTitleWidget extends StatelessWidget {
  final double fontSize;

  const WelcomeTitleWidget({super.key, this.fontSize = 22});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.l10n.welcomeToOurApp,
      style: GoogleFonts.poppins(fontSize: fontSize, fontWeight: FontWeight.w500, color: AppColors.primary),
    );
  }
}

// Welcome Subtitle Widget
class WelcomeSubtitleWidget extends StatelessWidget {
  final double fontSize;

  const WelcomeSubtitleWidget({super.key, this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.l10n.mobileLoginPrompt,
      textAlign: TextAlign.start,
      style: GoogleFonts.poppins(fontSize: fontSize, color: Colors.black54, fontWeight: FontWeight.w400),
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
      decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/egypt_flag.png', width: 24),
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

  const PhoneNumberFieldWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: "0123456789",
        hintStyle: GoogleFonts.poppins(color: const Color(0xFFCBCBCB)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      ),
    );
  }
}

// Continue Button Widget
class ContinueButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final double fontSize;

  const ContinueButtonWidget({super.key, required this.onPressed, this.fontSize = 16});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: onPressed,
        child: Text(
          context.l10n.commonContinue,
          style: GoogleFonts.poppins(fontSize: fontSize, color: Colors.white, fontWeight: FontWeight.w400),
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

  const SocialButtonWidget({super.key, required this.imagePath, required this.text, required this.onPressed});

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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            side: const BorderSide(color: AppColors.primary),
          ),
          onPressed: onPressed,
          child: Row(
            children: [
              Image.asset(imagePath, width: 22, height: 22),
              const SizedBox(width: 20),
              Text(text, style: GoogleFonts.poppins(fontSize: 16, color: const Color(0xFF414141))),
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
          horizontal: isLargeScreen ? MediaQuery.of(context).size.width * 0.2 : 20,
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
                Expanded(child: PhoneNumberFieldWidget(controller: phoneController)),
              ],
            ),
            const SizedBox(height: 20),

            // Continue button
            ContinueButtonWidget(onPressed: onContinuePressed, fontSize: isLargeScreen ? 20 : 16),
            const SizedBox(height: 20),

            // "Or" text
            Center(child: Text(context.l10n.commonOr, style: GoogleFonts.poppins(color: Colors.black54, fontSize: 16))),
            const SizedBox(height: 10),

            // Social login buttons
            SocialButtonWidget(
              imagePath: 'assets/images/mail_flag.png',
              text: context.l10n.continueWithEmail,
              onPressed: onEmailPressed,
            ),
            SocialButtonWidget(
              imagePath: 'assets/images/google_flag.png',
              text: context.l10n.continueWithGoogle,
              onPressed: onGooglePressed,
            ),
            SocialButtonWidget(
              imagePath: 'assets/images/facebook_flag.png',
              text: context.l10n.continueWithFacebook,
              onPressed: onFacebookPressed,
            ),
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
        Text(label, style: GoogleFonts.poppins(fontSize: 16, color: AppColors.secondTextColor, fontWeight: FontWeight.w400)),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            style: GoogleFonts.poppins(color: AppColors.grayTextColor, fontSize: 16, fontWeight: FontWeight.w400),
            inputFormatters:
                formatters ?? [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(maxLength)],
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(color: const Color(0xFFCBCBCB)),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
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
          backgroundColor:
              isEnabled
                  ? AppColors.primaryColor
                  // ignore: deprecated_member_use
                  : AppColors.primaryColor.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: isEnabled ? onPressed : null,
        child: Text(text, style: GoogleFonts.poppins(fontSize: fontSize, color: Colors.white, fontWeight: FontWeight.w600)),
      ),
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
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade300)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: InputBorder.none,
                hintStyle: GoogleFonts.poppins(color: Colors.grey.shade400, fontSize: 14),
              ),
            ),
          ),
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: isApplied ? Colors.grey.shade200 : AppColors.primaryColor,
              borderRadius: const BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
            ),
            child: TextButton(
              onPressed: onApplyPressed,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
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
// ------------------------ Summary Screen Widgets ------------------------

// Reserved Item Card Widget
class ReservedItemCardWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String location;
  final String details;
  final String startDate;
  final int guestNumber, nights;
  final double price, totalPrice;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ReservedItemCardWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.location,
    required this.details,
    required this.price,
    required this.guestNumber,
    required this.nights,
    required this.totalPrice,
    required this.startDate,
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
                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(10), right: Radius.circular(10)),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/IMAG.png',
                        image: imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 135,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
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
                              style: GoogleFonts.poppins(fontSize: 14, color: AppColors.secondTextColor),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Text(price.toString(), style: GoogleFonts.poppins(color: AppColors.secondTextColor, fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        location,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(color: AppColors.grayTextColor),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        details,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(color: AppColors.grayTextColor),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$guestNumber ${context.l10n.guests}",
                            style: GoogleFonts.poppins(color: AppColors.grayTextColor),
                          ),
                          Text("$nights ${context.l10n.nights}", style: GoogleFonts.poppins(color: AppColors.grayTextColor)),
                        ],
                      ),
                      Text(
                        '${context.l10n.commonTotal}: ${totalPrice.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          color: AppColors.secondTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
                  context.l10n.freeCancellationBefore(
                    startDate.split('T').first.replaceAll('-', '/').split('/').reversed.join('/'),
                  ),
                  style: GoogleFonts.poppins(color: AppColors.secondTextColor, fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (onEdit != null) InkWell(onTap: onEdit, child: SvgPicture.asset(ImageAssets.editIcon)),
                  const SizedBox(width: 10),
                  if (onDelete != null) InkWell(onTap: onDelete, child: SvgPicture.asset(ImageAssets.deleteIcon)),
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
  const PromoCodeSuccessMessageWidget({super.key, this.message = ''});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        message.isNotEmpty ? message : context.l10n.commonApply,
        style: GoogleFonts.poppins(color: AppColors.primaryColor, fontSize: 14, fontWeight: FontWeight.w400),
      ),
    );
  }
}

// Section Title Widget
class SectionTitleWidget extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;

  const SectionTitleWidget({super.key, required this.title, this.fontSize = 18, this.fontWeight = FontWeight.w600});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(fontSize: fontSize, fontWeight: fontWeight, color: AppColors.secondTextColor),
    );
  }
}

// // Summary Screen Content Widget
// class SummaryScreenContent extends StatelessWidget {
//   final List<Map<String, dynamic>> rentalItems;
//   final List<Map<String, dynamic>> activityItems;
//   final List<Map<String, String>> summaryItems;
//   final Widget promoCodeInput;
//   final bool showSuccessMessage;
//   final String successMessage;
//   final bool isApplied;
//   final String discountText;
//   final String savedAmount;
//   final String finalPrice;
//   final VoidCallback onPaymentMethodPressed;

//   const SummaryScreenContent({
//     super.key,
//     required this.rentalItems,
//     required this.activityItems,
//     required this.summaryItems,
//     required this.promoCodeInput,
//     required this.showSuccessMessage,
//     this.successMessage = "The promo code has been applied successfully",
//     this.isApplied = false,
//     this.discountText = "After Discount",
//     this.savedAmount = "(You Saved 100 SAR)",
//     this.finalPrice = "900 SAR",
//     required this.onPaymentMethodPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }
