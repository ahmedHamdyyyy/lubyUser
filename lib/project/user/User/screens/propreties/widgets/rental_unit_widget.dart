import 'package:flutter/material.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/widget/helper.dart';
import '../../../../Home/cubit/home_cubit.dart';

class RentalUnitWidget extends StatelessWidget {
  final HomeState state;
  const RentalUnitWidget({
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextWidget(
            text: '${state.property.details},',
            color: Color(0xFF414141),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          TextWidget(
            text: state.property.address,
            color: Color(0xFF414141),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 10),
          Text(
            '${state.property.guestNumber.toString()} Guests - ${state.property.type} - ${state.property.bedrooms.toString()} Bed - ${state.property.bathrooms.toString()} Bathroom',
            style: TextStyle(
              color: AppColors.grayTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),

          ),
          Row(
            children: [],
          ),
        ],
      ),
    );
  }
}
