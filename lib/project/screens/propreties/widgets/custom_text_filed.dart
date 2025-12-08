import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:luby2/core/localization/l10n_ext.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.maxLines,
    required this.text,
    required this.height,
    required this.width,
    required this.controller,
  });
  final TextEditingController controller;
  final int maxLines;
  final String text;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,

      child: TextFormField(
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return context.l10n.fillAllFields;
          } else {
            return null;
          }
        },
        maxLines: maxLines,
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: GoogleFonts.poppins(color: const Color(0xFFCBCBCB)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFCBCBCB)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFCBCBCB)),
          ),
        ),
      ),
    );
  }
}
