import 'package:flutter/material.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../core/localization/l10n_ext.dart';
import '../../../Home/cubit/home_cubit.dart';

class RentalUnitWidget extends StatelessWidget {
  final HomeState state;
  const RentalUnitWidget({required this.state, super.key});

  int get totalNights {
    final start = DateTime.tryParse(state.property.startDate) ?? DateTime.now();
    final end = DateTime.tryParse(state.property.endDate) ?? DateTime.now();
    return end.difference(start).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // TextWidget(
          //   text: context.l10n.entireRentalUnitIn(state.property.address.formattedAddress),
          //   color: Color(0xFF414141),
          //   fontSize: 16,
          //   fontWeight: FontWeight.w600,
          // ),
          // const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: Text(
              '${context.l10n.availableForRange(state.property.startDate.split('T').first.replaceAll('-', '/'), totalNights, context.l10n.nights, state.property.endDate.split('T').first.replaceAll('-', '/'))}${context.l10n.withPriceConnector}${context.l10n.sarAmount(state.property.pricePerNight)} ${context.l10n.perNightLabel}',
              style: const TextStyle(color: Color(0xFF262626), fontSize: 16),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '${state.property.guestNumber} ${context.l10n.guests} - ${state.property.type} - ${context.l10n.bedsCount(state.property.bedrooms)} - ${context.l10n.bathroomsCount(state.property.bathrooms)}',
            style: const TextStyle(color: AppColors.grayTextColor, fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
