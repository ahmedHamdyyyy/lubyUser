// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/widget/helper.dart';
import '../../../../core/localization/l10n_ext.dart';
import '../../../config/images/image_assets.dart';
import 'all_widget__complete_reservation_and_payment.dart';
import 'thank_you_screen.dart';

class ConfirmedPaymentScreen extends StatelessWidget {
  final String vendorId;
  const ConfirmedPaymentScreen({super.key, required this.vendorId});

  @override
  Widget build(BuildContext context) {
    // Define reservation items
    final List<Map<String, String>> reservationItems = [
      {'imagePath': 'assets/images/saudian_man.png', 'title': 'Studio - 5 Night', 'hostName': 'Mohamed Abdallah'},
      {'imagePath': 'assets/images/saudian_man.png', 'title': 'Activity Name - 2 person', 'hostName': 'Mohamed Abdallah'},
    ];

    // Define summary items
    final List<Map<String, String>> summaryItems = [
      {'title': '5 nights × 800', 'value': '4000 SAR'},
      {'title': '2 Person × 800', 'value': '4000 SAR'},
      {'title': 'Vat', 'value': '0 SAR'},
      {'title': 'Discount', 'value': '200 SAR'},
      {'title': 'Discount', 'value': '1000 SAR'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarPop(context, context.l10n.confirmedReservationTitle, AppColors.primary),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.confirmedReservationNumber('1234'),
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.secondTextColor),
            ),
            const SizedBox(height: 10),
            ...reservationItems.map(
              (item) => ReservationItemWidget(
                imagePath: item['imagePath']!,
                title: item['title']!,
                hostName: item['hostName']!,
                onMessageTap: () {
                  // final hostName = item['hostName']!;
                  // final imagePath = item['imagePath']!;
                  //TODO: handle chat hereeeeeee
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ChatScreen(
                  //       vendorId: vendorId,
                  //       userName: hostName,
                  //       userImage: imagePath,
                  //     ),
                  //   ),
                  // );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              context.l10n.summaryTitle,
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
            ),
            const SizedBox(height: 10),
            ...summaryItems.map((item) => SummaryRowWidget(title: item['title']!, value: item['value']!)),
            const Divider(),
            Card(
              elevation: 0,
              color: Colors.white,
              child: Row(
                children: [
                  Image.asset(ImageAssets.pdfIcon, width: 30, height: 30),
                  const SizedBox(width: 10),
                  Text(
                    context.l10n.viewReservationSummary,
                    style: GoogleFonts.poppins(color: AppColors.secondTextColor, fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const Spacer(),
                  SvgPicture.asset(ImageAssets.arrowDown, color: AppColors.primaryColor),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(height: 10),
            Text(
              context.l10n.paymentDisclaimer,
              style: GoogleFonts.poppins(color: AppColors.secondTextColor, fontSize: 14, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ThankYouScreen()));
                },
                child: Text(
                  context.l10n.doneLabel,
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
