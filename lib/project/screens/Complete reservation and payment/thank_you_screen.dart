import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/images/image_assets.dart';
import '../../../../../config/widget/helper.dart';
import '../../../../core/localization/l10n_ext.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarPop(context, context.l10n.thankYou, AppColors.primary),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(ImageAssets.checkCircle, width: 120, height: 120),
            const SizedBox(height: 20),
            Text(
              context.l10n.thankYou,
              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.primaryColor),
            ),
            const SizedBox(height: 10),
            Text(
              context.l10n.reservationCompleted,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 18, color: AppColors.secondTextColor, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
