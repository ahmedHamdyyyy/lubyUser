import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../config/widget/helper.dart';
import 'rental_details_view.dart';

class ContactHostScreen extends StatefulWidget {
  const ContactHostScreen({super.key});

  @override
  State<ContactHostScreen> createState() => _ContactHostScreenState();
}

class _ContactHostScreenState extends State<ContactHostScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 22),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RentalDetailScreen(id: '', index: 0)));
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 24,
                ),
                color: const Color(0xFF757575),
              ),
              const TextWidget(
                text: 'Contact the host',
                color: Color(0xFF757575),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
            child: TextWidget(
              text: 'You can now talk to the host',
              color: Color(0xFF1C1C1C),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Material(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    color: const Color(0xFFF6F7F9),
                  ),
                ),
                Column(
                
                  children: [

                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 30, bottom: 24),
                      child: Container(
                        height: 48,
                        width: 335,
                    /*     padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10), */
                        decoration: const BoxDecoration(
                          color: Color(0xFFF6F7F9),
                          
                        ),
                        child: Row(
                      
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 10),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                child: SizedBox(
                                  height: 48,
                                  width: 297,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: buildOutlineInputBorder(20),
                                      
                                      focusedBorder: buildOutlineInputBorder(20),
                                      hintText: 'message',
                                      hintStyle: const TextStyle(
                                        color: Color(0xFFD3D3D3),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {},
                                        icon: SvgPicture.asset(
                                          'assets/images/smileys.svg',
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 48,
                              height: 48,
                              decoration: const BoxDecoration(
                                color: Color(0xFF262626),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  'assets/images/microphone-2.svg',
                                  // ignore: deprecated_member_use
                                  color: const Color(0xFFFFFFFF),
                                  height: 24,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 0.0, right: 8, bottom: 24),
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //     decoration: const BoxDecoration(
          //       color: Color(0xFFF6F7F9),
          //     ),
          //     child: Row(
          //       children: [
          //         Expanded(
          //           child: Padding(
          //             padding: const EdgeInsets.only(left: 12.0),
          //             child: TextField(
          //               decoration: InputDecoration(
          //                 filled: true,
          //                 fillColor: Colors.white,
          //                 enabledBorder: buildOutlineInputBorder(25),
          //                 focusedBorder: buildOutlineInputBorder(25),
          //                 hintText: 'message',
          //                 hintStyle: const TextStyle(
          //                   color: Color(0xFFD3D3D3),
          //                   fontSize: 14,
          //                   fontWeight: FontWeight.w400,
          //                 ),
          //                 suffixIcon: IconButton(
          //                   onPressed: () {},
          //                   icon: SvgPicture.asset(
          //                     'assets/images/smileys.svg',
          //                     height: 24,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         const SizedBox(width: 8),
          //         Container(
          //           width: 40,
          //           height: 40,
          //           decoration: const BoxDecoration(
          //             color: Color(0xFF262626),
          //             shape: BoxShape.circle,
          //           ),
          //           child: IconButton(
          //             icon: SvgPicture.asset(
          //               'assets/images/microphone-2.svg',
          //               // ignore: deprecated_member_use
          //               color: const Color(0xFFFFFFFF),
          //               height: 24,
          //             ),
          //             onPressed: () {},
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
      // bottomNavigationBar: const BottomNavBarWidget(),
    );
  }
}
