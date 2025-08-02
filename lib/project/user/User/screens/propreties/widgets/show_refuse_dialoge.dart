import 'package:flutter/material.dart';
import '../../../../../../config/widget/helper.dart';
import 'custom_text_filed.dart';

Future<dynamic> showRefuseDialoge(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(15),
      child: Container(
        padding: const EdgeInsets.all(5),
        height: 382,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const TextWidget(
              text: 'refuse',
              color: Color(0xFF262626),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 120.0),
              child: Driver(),
            ),
            const SizedBox(
              height: 24,
            ),
          
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: TextWidget(
                    text: 'Enter the resson of rejection',
                    color: Color(0xFF414141),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 24.0, left: 10, right: 10, top: 12),
                  child: CustomTextField(
                    maxLines: 10,
                    text: '',
                    height: 138,
                    width: 295,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF262626),
                      //padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const TextWidget(
                      text: 'Send',
                      color: Color(0xFFFFFFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
