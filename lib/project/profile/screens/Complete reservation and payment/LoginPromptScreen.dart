// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../auth/view/Screen/auth/sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../config/images/image_assets.dart';

class LoginPromptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text ("Summary",style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.grayTextColor,
        ),),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageAssets.loginPromptScreen, height: 130, width: 130),
            SizedBox(height: 20),
            Text(
              "Please log in or register first to\ncomplete the booking",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: AppColors.primary,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignInScreen()),
                );
              },
              child: Text("Log in or register",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,  
                    fontWeight: FontWeight.w400,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
