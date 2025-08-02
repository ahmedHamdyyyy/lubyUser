import 'package:flutter/material.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/widget/helper.dart';
import '../../Complete reservation and payment/summary_screen.dart';

Future<dynamic> showReseverDialoge(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(5),
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
        height: 457,
        width: 335,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 0, right: 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextWidget(
                          text: 'Check in',
                          color: Color(0xFF414141),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                          height: 40,
                          width: 144,
                          child: TextField(
                            decoration: InputDecoration(
                                enabledBorder: buildOutlineInputBorder(5),
                                focusedBorder: buildOutlineInputBorder(5),
                                hintText: '1/4/2024',
                                hintStyle: const TextStyle(
                                  color: Color(0xFF757575),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextWidget(
                          text: 'Check out',
                          color: Color(0xFF414141),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                          height: 40,
                          width: 144,
                          child: TextField(
                            decoration: InputDecoration(
                              enabledBorder: buildOutlineInputBorder(
                                5,
                              ),
                              focusedBorder: buildOutlineInputBorder(5),
                              hintText: '6/4/2024',
                              hintStyle: const TextStyle(
                                color: Color(0xFF757575),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(
                  text: 'Guests No.',
                  color: Color(0xFF414141),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: buildOutlineInputBorder(5),
                      focusedBorder: buildOutlineInputBorder(5),
                      hintText: '2 Guests',
                      hintStyle: const TextStyle(
                        color: Color(0xFF757575),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      )),
                  ),
                ),
              ],
            ),
            const Column(
              children: [
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    TextWidget(
                      text: '99 x 2 person',
                      color: Color(0xFF414141),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    Spacer(),
                    TextWidget(
                      text: '496 SAR',
                      color: Color(0xFF414141),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                SizedBox(
                  height: 13,
                ),
                Row(
                  children: [
                    TextWidget(
                      text: 'Service Fees',
                      color: Color(0xFF414141),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    Spacer(),
                    TextWidget(
                      text: '20 SAR',
                      color: Color(0xFF414141),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Driver(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    children: [
                      TextWidget(
                        text: 'Total',
                        color: Color(0xFF414141),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      Spacer(),
                      TextWidget(
                        text: '496 SAR',
                        color: Color(0xFF414141),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const TextWidget(
              text: 'You won\'t be charged yet',
              color: Color(0xFF757575),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 34,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SummaryScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Center(
                          child: TextWidget(
                            text: 'Reserve',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 34,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grayColorIcon),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                          child: TextWidget(
                            text: 'Cancel',
                            color: Color(0xFF262626),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );


}
