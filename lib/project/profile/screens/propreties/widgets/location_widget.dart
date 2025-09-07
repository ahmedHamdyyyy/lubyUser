import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/widget/helper.dart';
import '../../../../Home/cubit/home_cubit.dart';

class LocationWidget extends StatelessWidget {
  final HomeState state;
  const LocationWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/location.svg',
                // ignore: deprecated_member_use
                color: const Color(0xFF414141),
                height: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  state.property.address.formattedAddress ?? '',
                  style: TextStyle(
                    color: AppColors.grayTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/map.svg',
                // ignore: deprecated_member_use
                color: AppColors.primaryColor,
                height: 24,
                width: 24,
              ),
              const SizedBox(width: 8),
              const TextWidget(
                text: 'View Location on Map',
                color: Color(0xFF262626),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
