// // ignore_for_file: file_names

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

// import '../../../../../../config/colors/colors.dart';
// import '../../../../../../config/images/image_assets.dart';
// // import 'package:fondok/core/widget/widgets.dart';
// import '../screens/reservations_screen.dart';

// class NoResurvation extends StatelessWidget {
//   const NoResurvation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         // appBar: appBarPop(context, "Reservation", AppColors.grayTextColor),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 22),
//             Row(
//               children: [
//                 const SizedBox(width: 20),
//                 Text(
//                   "Reservation",
//                   style: GoogleFonts.poppins(color: AppColors.grayTextColor, fontWeight: FontWeight.w500, fontSize: 14),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 22),
//             // Title "Your favorite"
//             Padding(
//               padding: const EdgeInsets.only(left: 24, top: 16),
//               child: InkWell(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => const ReservationsScreen()));
//                 },
//                 child: Text(
//                   'Reservation',
//                   style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
//                 ),
//               ),
//             ),

//             // Empty state content - centered in remaining space
//             Expanded(
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Bookmark icon with heart
//                     Container(
//                       width: 120,
//                       height: 120,
//                       margin: const EdgeInsets.only(bottom: 24),
//                       child: SvgPicture.asset(ImageAssets.noItemTaskes),
//                     ),

//                     Text(
//                       "You don't have any Reservation\nproducts yet",
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.poppins(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w400,
//                         color: AppColors.secondTextColor,
//                         height: 1.4,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
