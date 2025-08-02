import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.maxLines,
    required this.text,
    required this.height,
    required this.width,
  });
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
            return 'Filed is Empty';
          } else {
            return null;
          }
        },
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: GoogleFonts.poppins(
            color: const Color(0xFFCBCBCB),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFFCBCBCB),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFFCBCBCB),
            ),
          ),
        ),
      ),
    );
  }
}
