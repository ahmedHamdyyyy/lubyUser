import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
Future<dynamic> showImageDialoge(BuildContext context, String image, ) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(

      //backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Container(
            height: 335,
            width: double.infinity ,
            // margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(
                  image,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
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
        ],
      ),
     
    ),
  );
}
