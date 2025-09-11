import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/widget/helper.dart';
import '../../../../../../core/utils/utile.dart';
import '../../../models/activity.dart';
import '../../../models/reversation.dart';
import '../../../profile/screens/Complete reservation and payment/summary_screen.dart';

Future<dynamic> showActivityReserveDialoge(
  BuildContext context,
  ActivityModel activity,
  TextEditingController dateController,
  TextEditingController guestController,
) {
  final formKey = GlobalKey<FormState>();
  double? calculateTotalPrice() {
    final checkInDate = Utils.parseDate(dateController.text);
    final guestCount = int.tryParse(guestController.text) ?? 1;
    if (checkInDate != null) return activity.price * guestCount;
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
          width: 335,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextWidget(
                                text: 'Date',
                                color: Color(0xFF414141),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                height: 40,
                                width: 144,
                                child: TextFormField(
                                  controller: dateController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) return 'Please enter date';
                                    final date = Utils.parseDate(value);
                                    if (date == null) return 'Invalid date format';
                                    final now = DateTime.now();
                                    if (date.isBefore(now)) return 'date must be in the future';
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
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(height: 16),
                        Row(
                          children: [
                            TextWidget(
                              text: '${activity.price} x ${guestController.text.trim()} person',
                              color: Color(0xFF414141),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            Spacer(),
                            TextWidget(
                              text: '${activity.price * (int.tryParse(guestController.text.trim()) ?? 1)} SAR',
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
                                  final date = Utils.parseDate(dateController.text.trim());
                                  final guests = int.parse(guestController.text.trim());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SummaryScreen(
                                          reservation: ReservationModel.initial.copyWith(
                                            item: activity,
                                            guestNumber: guests,
                                            type: ReservationType.activity,
                                            checkInDate: date!.toIso8601String(),
                                            checkOutDate: date.toIso8601String(),
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
                    const SizedBox(height: 24),
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
