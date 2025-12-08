import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luby2/config/widget/widget.dart';
import 'package:luby2/core/localization/l10n_ext.dart';
import 'package:luby2/project/models/property.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/widget/helper.dart';
import '../../../../../core/utils/utile.dart';
import '../../../models/reversation.dart';
import '../../../reservation/view/screens/summary_screen.dart';
import 'date_field.dart';

Future<dynamic> showReseverDialoge(
  BuildContext context,
  PropertyModel property,
  String checkInDate,
  String checkOutDate,
  String guestsCount,
) {
  final guestController = TextEditingController(text: guestsCount);
  final formKey = GlobalKey<FormState>();
  double calculateTotalPrice() {
    final duration = DateTime.parse(checkOutDate).difference(DateTime.parse(checkInDate)).inDays.abs();
    return duration * property.pricePerNight;
  }

  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, left: 0, right: 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: DateField(
                              date: checkInDate,
                              start: property.startDate,
                              end: property.endDate,
                              title: context.l10n.checkIn.trim(),
                              onDateSelected: (date) {
                                final selectedDate = DateTime.tryParse(date) ?? DateTime.now();
                                final checkOut =
                                    DateTime.tryParse(checkOutDate) ?? selectedDate.add(const Duration(days: 1));
                                if (!checkOut.isAfter(selectedDate)) {
                                  checkOutDate = selectedDate.add(const Duration(days: 1)).toIso8601String();
                                  setState(() {});
                                }
                                checkInDate = date;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DateField(
                              date: checkOutDate,
                              title: context.l10n.checkOut.trim(),
                              start: property.startDate,
                              end: property.endDate,
                              onDateSelected: (date) {
                                final selectedDate = DateTime.tryParse(date) ?? DateTime.now();
                                final checkIn =
                                    DateTime.tryParse(checkInDate) ?? selectedDate.subtract(const Duration(days: 1));
                                if (!selectedDate.isAfter(checkIn)) {
                                  checkInDate = selectedDate.subtract(const Duration(days: 1)).toIso8601String();
                                  setState(() {});
                                }
                                checkOutDate = date;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: context.l10n.guestsNoLabel,
                          color: Color(0xFF414141),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(height: 4),
                        TextFormField(
                          controller: guestController,
                          validator: (value) {
                            if (value == null || value.isEmpty) return context.l10n.invalidGuestNumber;
                            final guests = int.tryParse(value);
                            if (guests == null || guests < 1) return context.l10n.invalidGuestNumber;
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          onChanged: (value) => setState(() {}),
                          decoration: InputDecoration(
                            enabledBorder: buildOutlineInputBorder(5),
                            focusedBorder: buildOutlineInputBorder(5),
                            hintText: context.l10n.guestCountHint,
                            hintStyle: const TextStyle(color: Color(0xFF757575), fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextWidget(
                                text:
                                    '${context.l10n.sarAmount(property.pricePerNight)} × ${Utils.calculateDaysDifference(checkInDate, checkOutDate)} ${context.l10n.nights}',
                                color: Color(0xFF414141),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextWidget(
                              text: context.l10n.sarAmount(
                                property.pricePerNight * Utils.calculateDaysDifference(checkInDate, checkOutDate),
                              ),
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
                              text: context.l10n.serviceFees,
                              color: Color(0xFF414141),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            Spacer(),
                            TextWidget(
                              text: '${context.l10n.sarAmount(4)}%',
                              color: Color(0xFF414141),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                    TextWidget(
                      text: context.l10n.notChargedYet,
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
                                  final checkinDate = DateTime.parse(checkInDate);
                                  final checkoutDate = DateTime.parse(checkOutDate);
                                  final guests = int.parse(guestController.text.trim());
                                  if (checkinDate.isAfter(checkoutDate)) {
                                    return showToast(text: context.l10n.checkInBeforeCheckOut, stute: ToustStute.worning);
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
                                            totalPrice: (calculateTotalPrice()).toDouble(),
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
                                child: Center(
                                  child: TextWidget(
                                    text: context.l10n.reserveLabel,
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
                                child: Center(
                                  child: TextWidget(
                                    text: context.l10n.commonCancel,
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
