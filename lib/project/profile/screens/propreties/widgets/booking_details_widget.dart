import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/colors/colors.dart';
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
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(color: AppColors.secondTextColor, fontSize: 16, fontWeight: FontWeight.w400),
              children: [
                const TextSpan(text: 'Available For '),
                TextSpan(text: '$totalNights Night', style: const TextStyle(fontWeight: FontWeight.w600)),
                const TextSpan(text: ' from '),
                TextSpan(
                  text: property.startDate.split('T').first.replaceAll('-', '/'),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const TextSpan(text: ' to '),
                TextSpan(
                  text: property.endDate.split('T').first.replaceAll('-', '/'),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const TextSpan(text: ' with price '),
                TextSpan(text: '${property.pricePerNight}', style: const TextStyle(fontWeight: FontWeight.w600)),
                const TextSpan(text: ' Per Night'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (property.reservationId.isNotEmpty) ...[
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
      ],
    ),
  );
}
