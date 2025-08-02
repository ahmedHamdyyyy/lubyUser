import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../config/widget/helper.dart';

// Privacy Policy Header Widget
class PrivacyHeader extends StatelessWidget {
  const PrivacyHeader({super.key});

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
              text: 'Privacy Policy',
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
            text: 'Privacy Policy',
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

// Main Privacy Content Widget
class PrivacyContent extends StatelessWidget {
  const PrivacyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PrivacyHeader(),
          const SizedBox(height: 30),
          const FirstParagraphWidget(),
          const StandardParagraphWidget(),
          const StandardParagraphWidget(),
        ],
      ),
    );
  }
}
