import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/widget/helper.dart';
import '../../../../Home/cubit/home_cubit.dart';

class BookingDetailsWidget extends StatelessWidget {
  final HomeState state;
  const BookingDetailsWidget({
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        children: [
           Row(
            children: [
              TextWidget(
                text: '${state.property.pricePerNight.toString()} SAR',
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              TextWidget(
                text: '${state.property.guestNumber.toString()} Night',
                color: AppColors.secondTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              TextWidget(
                text: ' - 649 Per Night',
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
                  'Free cancellation before 27 October',
                  style: GoogleFonts.poppins(
                    color: AppColors.secondTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    //overflow: TextOverflow.ellipsis,
                  ),
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
