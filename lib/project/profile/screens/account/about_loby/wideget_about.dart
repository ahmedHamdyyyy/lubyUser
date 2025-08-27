import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../config/images/assets.dart';
import '../../../../../../config/widget/helper.dart';

// Header widget with back button and title
class AboutLobyHeader extends StatelessWidget {
  const AboutLobyHeader({super.key});

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
              text: 'About lOBY',
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
            text: 'About lOBY',
            color: Color(0xFF1C1C1C),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// Image container widget
class AboutLobyImage extends StatelessWidget {
  const AboutLobyImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 198,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsData.loby),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

// First paragraph widget
class AboutLobyFirstParagraph extends StatelessWidget {
  const AboutLobyFirstParagraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: 101,
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

// Second paragraph widget
class AboutLobySecondParagraph extends StatelessWidget {
  const AboutLobySecondParagraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: 201,
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

// Main body widget that combines all content
class AboutLobyBody extends StatelessWidget {
  const AboutLobyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AboutLobyHeader(),
        const AboutLobyImage(),
        const SizedBox(height: 30),
        const AboutLobyFirstParagraph(),
        const SizedBox(height: 16),
        const AboutLobySecondParagraph(),
      ],
    );
  }
}
