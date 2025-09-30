import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/widget/helper.dart';

class ListTileItem extends StatelessWidget {
  const ListTileItem({super.key, required this.icon, required this.text});

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            // ignore: deprecated_member_use
            color: AppColors.grayTextColor,
            height: 24,
          ),
          const SizedBox(width: 16),
          TextWidget(text: text, color: AppColors.grayTextColor, fontSize: 16, fontWeight: FontWeight.w500),
        ],
      ),
    );
  }
}
