import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../config/colors/colors.dart';

class CityDropdown extends StatelessWidget {
  const CityDropdown({
    super.key,
    required this.title,
    required this.hint,
    required this.list,
    this.selectedCity,
    required this.onChanged,
  });
  final String title;
  final String hint;
  final List<String> list;
  final String? selectedCity;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.secondTextColor)),
      const SizedBox(height: 8),
      Container(
        height: 40,
        decoration: BoxDecoration(border: Border.all(color: AppColors.lightGray), borderRadius: BorderRadius.circular(5)),
        child: DropdownButtonFormField<String>(
          dropdownColor: Colors.white,
          value: selectedCity,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.grayTextColor),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: AppColors.primaryWhite),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: AppColors.lightGray),
            ),
            hintText: hint,
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
            border: InputBorder.none,
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.grayTextColor),
          onChanged: (newValue) {
            if (newValue != null) onChanged(newValue);
          },
          items:
              list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.grayTextColor),
                  ),
                );
              }).toList(),
        ),
      ),
    ],
  );
}
