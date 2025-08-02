import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../config/widget/helper.dart';
import '../../../../../../config/images/image_assets.dart';

// Terms and Conditions Header Widget
class TermsHeader extends StatelessWidget {
  const TermsHeader({super.key});

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
              text: 'Terms and Conditions',
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
            text: 'Terms and Conditions',
            color: Color(0xFF1C1C1C),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// First Paragraph Widget
class FirstParagraphWidget extends StatelessWidget {
  const FirstParagraphWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: 95,
        width: 335,
        child: Text(
          textAlign: TextAlign.start,
          'Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay prm gravida felis, sociis in felis.Diam habitant .',
          style: GoogleFonts.poppins(
            color: const Color(0xFF757575),
            fontSize: 16,
            height: 1.3,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

// Standard Paragraph Widget
class StandardParagraphWidget extends StatelessWidget {
  const StandardParagraphWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: 191,
        width: 335,
        child: Text(
          textAlign: TextAlign.start,
          'Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay prm gravida felis, sociis in felis.Diam habitant .Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay prm gravida felis, sociis in felis.Diam habitant .',
          style: GoogleFonts.poppins(
            color: const Color(0xFF757575),
            fontSize: 16,
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

// Agreement Checkbox Widget
class AgreementCheckbox extends StatelessWidget {
  final bool isChecked;
  final VoidCallback onToggle;

  const AgreementCheckbox({
    super.key,
    required this.isChecked,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
          onPressed: onToggle,
          icon: isChecked
              ? SvgPicture.asset(
                  ImageAssets.cracalBlack,
                  height: 24,
                  width: 24,
                )
              : SvgPicture.asset(
                  ImageAssets.cracalWhite,
                  height: 24,
                  width: 24,
                ),
          label: const TextWidget(
            text: 'Agree to the terms and conditions',
            color: Color(0xFF414141),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 20,
            ),
            alignment: Alignment.centerLeft,
          ),
        ),
      ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: 48,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF262626),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const TextWidget(
            text: 'Done',
            color: Color(0xFFFFFFFF),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

// Main Terms Content Widget
class TermsContent extends StatelessWidget {
  final bool isAgreed;
  final VoidCallback onAgreementToggle;
  final VoidCallback onDonePressed;

  const TermsContent({
    super.key,
    required this.isAgreed,
    required this.onAgreementToggle,
    required this.onDonePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TermsHeader(),
          const FirstParagraphWidget(),
          const StandardParagraphWidget(),
          const StandardParagraphWidget(),
          AgreementCheckbox(
            isChecked: isAgreed,
            onToggle: onAgreementToggle,
          ),
          const SizedBox(height: 14),
          DoneButtonWidget(onPressed: onDonePressed),
        ],
      ),
    );
  }
}
