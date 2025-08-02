import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../config/widget/helper.dart';
import '../../Complete reservation and payment/LoginPromptScreen.dart';
import 'custom_text_filed.dart';

Future<dynamic> showReviewDialoge(BuildContext context) {
  
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 402,
        width: 400,
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 20),
                    child: SvgPicture.asset(
                      'assets/images/close-square.svg',
                      // ignore: deprecated_member_use
                      color: const Color(0xFF414141),
                      height: 24,
                    ),
                  ),
                )
              ],
            ),
            const TextWidget(
              text: 'Add Review',
              color: Color(0xFF262626),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.0),
              child: Driver(),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const TextWidget(
                    text: 'Rate Apartment',
                    color: Color(0xFF414141),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                  
                    children: List.generate(
                      
                      5,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: SvgPicture.asset(
                          'assets/images/stare.svg',
                          // ignore: deprecated_member_use
                          color: const Color(0xFF414141),
                          height: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: TextWidget(
                    text: 'Add Comment',
                    color: Color(0xFF414141), 
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 24,  right: 4, top: 8),
                  child: CustomTextField(
                    maxLines: 4,
                    text: 'Add your comment here',
                    height: 90,
                    width: 295,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 295,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPromptScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF262626),
                      //padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const TextWidget(
                      text: 'Add',
                      color: Color(0xFFFFFFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
