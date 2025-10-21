import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/widget/helper.dart';
import '../../../../../core/localization/l10n_ext.dart';
import '../../../models/activity.dart';

class ActivityBookingDetailsWidget extends StatelessWidget {
  final ActivityModel activity;
  const ActivityBookingDetailsWidget({required this.activity, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        children: [
          Row(
            children: [
              TextWidget(
                text: '${activity.price} Per Night',
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
                  context.l10n.freeCancellationBefore(activity.date.split('T').first.replaceAll('-', '/')),
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
