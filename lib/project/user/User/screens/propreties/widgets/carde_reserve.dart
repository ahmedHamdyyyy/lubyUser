import 'package:flutter/material.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/widget/helper.dart';
import 'show_reserve_dialoge.dart';

class CardeReserve extends StatelessWidget {
  const CardeReserve({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextWidget(
                      text: 'Check in',
                      color: AppColors.secondTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      height: 40,
                      width: 144,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: buildOutlineInputBorder(5),
                          focusedBorder: buildOutlineInputBorder(5),
                          hintText: '1/4/2024',
                          hintStyle: const TextStyle(
                            color: AppColors.grayTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                    )),
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
                      color: AppColors.secondTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      height: 40,
                      width: 144,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: buildOutlineInputBorder(5), 
                            focusedBorder: buildOutlineInputBorder(5),
                            hintText: '6/4/2024',
                            hintStyle: const TextStyle(
                              color: AppColors.grayTextColor,
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
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextWidget(
                text: 'Guests No.',
                color: AppColors.secondTextColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: buildOutlineInputBorder(5),
                    focusedBorder: buildOutlineInputBorder(5),
                    hintText: '2 Guests',
                    hintStyle: const TextStyle(
                      color: AppColors.grayTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )),
              )   ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                showReseverDialoge(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                //padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const TextWidget(
                text: 'Reserve',
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
