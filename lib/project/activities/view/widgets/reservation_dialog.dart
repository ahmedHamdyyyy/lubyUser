import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/widget/helper.dart';
import '../../../../../../core/utils/utile.dart';
import '../../../../../core/localization/l10n_ext.dart';
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
                              TextWidget(
                                text: context.l10n.dateLabel.trim(),
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
                                    if (value == null || value.isEmpty) return context.l10n.pleaseEnterDate;
                                    final date = Utils.parseDate(value);
                                    if (date == null) return context.l10n.invalidDateFormat;
                                    final now = DateTime.now();
                                    if (date.isBefore(now)) return context.l10n.dateMustBeInFuture;
                                    return null;
                                  },
                                  keyboardType: TextInputType.datetime,
                                  onChanged: (value) => setState(() {}),
                                  decoration: InputDecoration(
                                    enabledBorder: buildOutlineInputBorder(5),
                                    focusedBorder: buildOutlineInputBorder(5),
                                    hintText: context.l10n.enterDateInDdMmYyyy,
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
                              TextWidget(
                                text: context.l10n.guestsNoLabel,
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
                              text: context.l10n.priceTimesGuests(
                                activity.price,
                                int.tryParse(guestController.text.trim()) ?? 1,
                              ),
                              color: Color(0xFF414141),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            Spacer(),
                            TextWidget(
                              text: context.l10n.sarAmount(
                                activity.price * (int.tryParse(guestController.text.trim()) ?? 1),
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
                              text: context.l10n.sarAmount(20),
                              color: Color(0xFF414141),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Driver(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            children: [
                              TextWidget(
                                text: context.l10n.commonTotal,
                                color: Color(0xFF414141),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              Spacer(),
                              TextWidget(
                                text:
                                    calculateTotalPrice() == null
                                        ? '---'
                                        : context.l10n.sarAmount(calculateTotalPrice()!.toInt()),
                                color: Color(0xFF414141),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
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
