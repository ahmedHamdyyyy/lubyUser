import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/widget/helper.dart';
import '../../../../models/property.dart';

class BookingDetailsWidget extends StatelessWidget {
  const BookingDetailsWidget({required this.property, super.key});
  final PropertyModel property;

  int get totalNights {
    final start = DateTime.tryParse(property.startDate) ?? DateTime.now();
    final end = DateTime.tryParse(property.endDate) ?? DateTime.now();
    return end.difference(start).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        children: [
          Row(
            children: [
              TextWidget(
                text: '${totalNights * property.pricePerNight} SAR',
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: TextWidget(
                  text: '$totalNights Night',
                  color: AppColors.secondTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextWidget(
                text: '${property.pricePerNight} Per Night',
                color: AppColors.grayTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/images/clipboard-close.svg',
                // ignore: deprecated_member_use
                color: AppColors.secondTextColor,
                height: 24,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Free cancellation before ${property.startDate.split('T').first.replaceAll('-', '/')}',
                  style: GoogleFonts.poppins(color: AppColors.secondTextColor, fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
