import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../../../core/localization/l10n_ext.dart';
import '../../../../models/property.dart';
import '../../../../models/reversation.dart';

class BookingDetailsWidget extends StatelessWidget {
  const BookingDetailsWidget({required this.property, super.key});
  final PropertyModel property;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (property.reservationId.isNotEmpty) ...[
          Builder(
            builder: (context) {
              final statusText = () {
                switch (property.reservationStatus) {
                  case ReservationStatus.draft:
                    return context.l10n.reservationStatusDraft;
                  case ReservationStatus.completed:
                    return context.l10n.reservationStatusCompleted;
                  case ReservationStatus.canceled:
                    return context.l10n.reservationStatusCanceled;
                }
              }();
              return Text(
                '${context.l10n.yourBookingDetails}\n'
                '$statusText\n'
                '${context.l10n.checkIn}${property.reservationCheckInDate.split('T').first.replaceAll('-', '/')}\n'
                '${context.l10n.checkOut}${property.reservationCheckOutDate.split('T').first.replaceAll('-', '/')}\n'
                '${property.reservationGuestNumber} ${context.l10n.guests}\n'
                '${context.l10n.reservationNumber(property.reservationNumber)}\n'
                '${context.l10n.commonTotal}: ${context.l10n.sarAmount(property.reservationTotalPrice)}',
                style: GoogleFonts.poppins(color: AppColors.secondTextColor, fontSize: 16, fontWeight: FontWeight.w500),
              );
            },
          ),
          const SizedBox(height: 10),
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
                  context.l10n.freeCancellationBefore(property.startDate.split('T').first.replaceAll('-', '/')),
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
