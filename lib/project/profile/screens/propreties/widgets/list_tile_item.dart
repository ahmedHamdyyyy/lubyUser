import 'package:flutter/material.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/widget/helper.dart';

class ListTileItem extends StatelessWidget {
  const ListTileItem({super.key, required this.text});
  final String text;
  IconData _iconForTag(String tag) {
    switch (tag.toLowerCase()) {
      case 'waterfront':
        return Icons.water;
      case 'wifi':
        return Icons.wifi;
      case 'washing machine':
        return Icons.local_laundry_service;
      case 'air conditioning':
        return Icons.ac_unit;
      case 'kitchen':
        return Icons.kitchen;
      case 'parking':
        return Icons.local_parking;
      case 'pool':
        return Icons.pool;
      case 'gym':
        return Icons.fitness_center;
      case 'tv':
        return Icons.tv;
      case 'heating':
        return Icons.whatshot;
      case 'fireplace':
        return Icons.fireplace;
      case 'pets allowed':
        return Icons.pets;
      case 'breakfast':
        return Icons.free_breakfast;
      case 'smoking allowed':
        return Icons.smoking_rooms;
      case 'elevator':
        return Icons.elevator;
      case 'hot tub':
        return Icons.hot_tub;
      case 'garden':
        return Icons.grass;
      case 'bbq':
        return Icons.outdoor_grill;
      case 'childrens pool':
        return Icons.pool;
      case 'playground':
        return Icons.sports_soccer;
      case 'tennis court':
        return Icons.sports_tennis;
      case 'beach access':
        return Icons.beach_access;
      case 'golf course':
        return Icons.golf_course;
      case 'hiking':
        return Icons.hiking;
      case 'skiing':
        return Icons.downhill_skiing;
      case 'fishing':
        return Icons.set_meal;
      default:
        return Icons.check;
    }
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Icon(_iconForTag(text), color: AppColors.grayTextColor, size: 24),
        const SizedBox(width: 16),
        TextWidget(text: text, color: AppColors.grayTextColor, fontSize: 16, fontWeight: FontWeight.w500),
      ],
    ),
  );
}
