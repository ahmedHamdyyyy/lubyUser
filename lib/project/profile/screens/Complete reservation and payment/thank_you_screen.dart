import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/images/image_assets.dart';
import '../../../../../../config/widget/helper.dart';
import 'package:google_fonts/google_fonts.dart';
class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    appBar: appBarPop(context,"Thank you",AppColors.primary),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SvgPicture.asset(ImageAssets.checkCircle,width: 120,height: 120 ,),
            const SizedBox(height: 20),
             Text(
              "Thank you",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Your reservation has been\nsuccessfully completed.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: AppColors.secondTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
