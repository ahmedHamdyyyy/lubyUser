import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/images/image_assets.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:fondok/feature/User/screens/Conversations/conversations_screen.dart';

import 'favourite2.dart';

class NoItemInFavorite extends StatelessWidget {
  const NoItemInFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 20),
                Text(
                  "favorite",
                  style: TextStyle(
                    color: AppColors.grayTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                )
              ],
            ),
            const SizedBox(height: 22),

            // Title "Your favorite"
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                top: 16,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Favorite2Screen(),
                      ));
                },
                child:  Text(
                  'Your favorite',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),

            // Empty state content - centered in remaining space
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Bookmark icon with heart
                    Container(
                      width: 120,
                      height: 120,
                      margin: const EdgeInsets.only(bottom: 24),
                      child: SvgPicture.asset(
                        ImageAssets.noItemInFavorite,
                      ),
                    ),

                    Text(
                      "You don't have any Favorite\nproducts yet",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondTextColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
