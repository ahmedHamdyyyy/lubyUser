// // ignore_for_file: unused_element

// import 'package:flutter/material.dart';
// import '../widgets/bottom_nav_bar_widget.dart';
// import '../widgets/show_refuse_dialoge.dart';

// class ReservationDetailsScreen extends StatelessWidget {
//   const ReservationDetailsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 22),
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {},
//                     icon: const Icon(
//                       Icons.arrow_back_ios_new,
//                       size: 24,
//                     ),
//                     color: const Color(0xFF757575),
//                   ),
//                   const Text(
//                     'Current Reservations',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 16),
//               // Reservation Number
//               const Text(
//                 'Reservation Number 1234',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Client Info
//               _buildClientInfo(),
//               const SizedBox(height: 20),

//               // First Activity
//               _buildActivityItem(
//                 imagePath: 'assets/images/man-rides-camel.jpg',
//                 title: 'Studio - 5 Night',
//                 location: 'Riyadh - District Name',
//                 price: '4000 SAR',
//                 isFirstActivity: true,
//               ),
//               const SizedBox(height: 16),
//               const Padding(
//                 padding: EdgeInsets.only(left: 0.0),
//                 child: Text(
//                   'Free cancellation before 27 October',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),

//               // First Order Details
//               _buildOrderDetails(
//                 activityName: 'Activity name',
//                 location: 'Riyadh - District Name',
//                 date: 'Date 14\\10\\2024',
//                 price: 'Price : 1230 SAR',
//               ),

//               const SizedBox(height: 16),

//               // Second Activity
//               _buildActivityItem(
//                 imagePath: 'assets/images/two-people.jpg',
//                 title: 'Activity name',
//                 location: 'Riyadh - District Name',
//                 price: '4000 SAR',
//                 isFirstActivity: false,
//               ),
//               const SizedBox(height: 16),
//               const Padding(
//                 padding: EdgeInsets.only(left: 0.0),
//                 child: Text(
//                   'Free cancellation before 27 October',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),

//               // Second Order Details
//               _buildOrderDetails(
//                 activityName: 'Studio - 5 Night',
//                 location: 'Riyadh - District Name',
//                 date: 'Date 14\\10\\2024',
//                 price: 'Price : 1230 SAR',
//               ),

//               const SizedBox(height: 16),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 0.0),
//                 child: const Divider(),
//               ),
//               const SizedBox(height: 16),

//               // Summary
//               const Text(
//                 'Summary',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 12),

//               // Summary Details
//               _buildSummaryItem('2 Person × 800', '4000 SAR'),
//               _buildSummaryItem('Vat', '0 SAR'),
//               _buildSummaryItem('Discount', '200 SAR'),
//               _buildSummaryItem('Discount', '1000 SAR'),

//               const SizedBox(height: 16),
//               const Divider(),
//               const SizedBox(height: 16),

//               // Note
//               Row(
//                 children: const [
//                   Icon(Icons.edit_note, size: 20, color: Colors.grey),
//                   SizedBox(width: 8),
//                   Text(
//                     'Note : The client has paid the fues',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 16),

//               // Action Buttons
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.black,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: const Text('Accept'),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () {
//                         showRefuseDialoge(context);
//                       },
//                       style: OutlinedButton.styleFrom(
//                         foregroundColor: Colors.black,
//                         side: const BorderSide(color: Colors.black),
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: const Text('Refuse'),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 16),

//               // View Reservation Summary
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.shade200),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: ListTile(
//                   leading: const Icon(
//                     Icons.article_outlined,
//                     color: Colors.red,
//                   ),
//                   title: const Text(
//                     'View reservation summary',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   trailing: const Icon(Icons.chevron_right),
//                   onTap: () {},
//                 ),
//               ),

//               const SizedBox(height: 24), // Space for the bottom nav bar
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: const BottomNavBarWidget(),
//     );
//   }

//   Widget _buildClientInfo() {
//     return Row(
//       children: [
//         Container(
//           width: 50,
//           height: 50,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             image: const DecorationImage(
//               image: AssetImage('assets/images/person.jpg'),
//               fit: BoxFit.cover,
//             ),
//             border: Border.all(color: Colors.grey.shade300, width: 1),
//           ),
//         ),
//         const SizedBox(width: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text(
//               'Client Name',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               'Mohamed Abdallah',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//         const Spacer(),
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade300),
//             shape: BoxShape.circle,
//           ),
//           child: const Icon(
//             Icons.chat_bubble_outline,
//             size: 20,
//             color: Colors.black,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildActivityItem({
//     required String imagePath,
//     required String title,
//     required String location,
//     required String price,
//     required bool isFirstActivity,
//   }) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: Image.asset(
//             imagePath,
//             width: 101,
//             height: 101,
//             fit: BoxFit.cover,
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 location,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Text(
//           price,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildOrderDetails({
//     required String activityName,
//     required String location,
//     required String date,
//     required String price,
//   }) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Order details',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             activityName,
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.grey,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             location,
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.grey,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             date,
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.grey,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             price,
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSummaryItem(String label, String amount) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//               fontSize: 16,
//               color: Colors.grey,
//             ),
//           ),
//           Text(
//             amount,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomNavigationBar() {
//     return Container(
//       height: 70,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.1),
//             blurRadius: 10,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildNavItem(Icons.home_outlined, true),
//           _buildNavItem(Icons.shopping_bag_outlined, false),
//           _buildNavItem(Icons.chat_bubble_outline, false),
//           _buildNavItem(Icons.person_outline, false),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(IconData icon, bool isSelected) {
//     return IconButton(
//       icon: Icon(
//         icon,
//         color: isSelected ? Colors.blue : Colors.grey,
//         size: 28,
//       ),
//       onPressed: () {},
//     );
//   }
// }
