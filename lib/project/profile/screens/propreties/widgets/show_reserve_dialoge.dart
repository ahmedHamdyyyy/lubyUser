import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luby2/config/widget/widget.dart';
import 'package:luby2/project/models/property.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/widget/helper.dart';
import '../../../../../../core/utils/utile.dart';
import '../../../../models/reversation.dart';
import '../../Complete reservation and payment/summary_screen.dart';

Future<dynamic> showReseverDialoge(
  BuildContext context,
  PropertyModel property,
  TextEditingController checkInController,
  TextEditingController checkOutController,
  TextEditingController guestController,
) {
  final formKey = GlobalKey<FormState>();
  double? calculateTotalPrice() {
    final checkInDate = Utils.parseDate(checkInController.text);
    final checkOutDate = Utils.parseDate(checkOutController.text);
    final guestCount = int.tryParse(guestController.text) ?? 1;

    if (checkInDate != null && checkOutDate != null) {
      final duration = checkOutDate.difference(checkInDate).inDays;
      return duration * property.pricePerNight * guestCount;
    }
    return null;
  }

  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.all(5),
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
          height: 457,
          width: 335,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Form(
                key: formKey,
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
                                const SizedBox(height: 4),
                                SizedBox(
                                  height: 40,
                                  width: 144,
                                  child: TextFormField(
                                    controller: checkInController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return 'Please enter check-in date';
                                      final date = Utils.parseDate(value);
                                      if (date == null) return 'Invalid date format';
                                      final now = DateTime.now();
                                      if (date.isBefore(now)) return 'check-in date must be in the future';
                                      return null;
                                    },
                                    keyboardType: TextInputType.datetime,
                                    onChanged: (value) => setState(() {}),
                                    decoration: InputDecoration(
                                      enabledBorder: buildOutlineInputBorder(5),
                                      focusedBorder: buildOutlineInputBorder(5),
                                      hintText: 'dd/mm/yyyy',
                                      hintStyle: const TextStyle(
                                        color: Color(0xFF757575),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
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
                                const SizedBox(height: 4),
                                SizedBox(
                                  height: 40,
                                  width: 144,
                                  child: TextFormField(
                                    controller: checkOutController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return 'Please enter check-in date';
                                      final date = Utils.parseDate(value);
                                      if (date == null) return 'Invalid date format';
                                      final now = DateTime.now();
                                      if (date.isBefore(now)) return 'check-in date must be in the future';
                                      return null;
                                    },
                                    keyboardType: TextInputType.datetime,
                                    onChanged: (value) => setState(() {}),
                                    decoration: InputDecoration(
                                      enabledBorder: buildOutlineInputBorder(5),
                                      focusedBorder: buildOutlineInputBorder(5),
                                      hintText: '6/4/2024',
                                      hintStyle: const TextStyle(
                                        color: Color(0xFF757575),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
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
                        const SizedBox(height: 4),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: TextFormField(
                            controller: guestController,
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'invalid guest number';
                              final guests = int.tryParse(value);
                              if (guests == null || guests < 1) return 'invalid guest number';
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            onChanged: (value) => setState(() {}),
                            decoration: InputDecoration(
                              enabledBorder: buildOutlineInputBorder(5),
                              focusedBorder: buildOutlineInputBorder(5),
                              hintText: '1 Guests',
                              hintStyle: const TextStyle(
                                color: Color(0xFF757575),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(height: 16),
                        Row(
                          children: [
                            TextWidget(
                              text: '${property.pricePerNight} x ${guestController.text.trim()} person',
                              color: Color(0xFF414141),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            Spacer(),
                            TextWidget(
                              text: '${property.pricePerNight * (int.tryParse(guestController.text.trim()) ?? 1)} SAR',
                              color: Color(0xFF414141),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        SizedBox(height: 13),
                        Row(
                          children: [
                            TextWidget(
                              text: 'Service Fees',
                              color: Color(0xFF414141),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            Spacer(),
                            TextWidget(text: '20 SAR', color: Color(0xFF414141), fontSize: 16, fontWeight: FontWeight.w400),
                          ],
                        ),
                        SizedBox(height: 24),
                        Driver(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            children: [
                              TextWidget(text: 'Total', color: Color(0xFF414141), fontSize: 16, fontWeight: FontWeight.w600),
                              Spacer(),
                              TextWidget(
                                text: '${calculateTotalPrice() ?? '---'} SAR',
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
                                  if (!formKey.currentState!.validate()) return;
                                  final checkinDate = Utils.parseDate(checkInController.text.trim());
                                  final checkoutDate = Utils.parseDate(checkOutController.text.trim());
                                  final guests = int.parse(guestController.text.trim());
                                  if (checkinDate!.isAfter(checkoutDate!)) {
                                    return showToast(
                                      text: 'check in Date must be before check out date',
                                      stute: ToustStute.worning,
                                    );
                                  }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SummaryScreen(
                                          reservation: ReservationModel.initial.copyWith(
                                            item: property,
                                            guestNumber: guests,
                                            type: ReservationType.property,
                                            checkInDate: checkinDate.toIso8601String(),
                                            checkOutDate: checkoutDate.toIso8601String(),
                                            totalPrice: (calculateTotalPrice() ?? 0).toDouble(),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
                          const SizedBox(width: 17),
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
              );
            },
          ),
        ),
      );
    },
  );
}
