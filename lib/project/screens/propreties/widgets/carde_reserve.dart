import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luby2/core/localization/l10n_ext.dart';
import 'package:luby2/project/screens/propreties/widgets/date_field.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/widget/helper.dart';
import '../../../models/property.dart';
import 'show_reserve_dialoge.dart';

class CardeReserve extends StatefulWidget {
  const CardeReserve({super.key, required this.property});
  final PropertyModel property;
  @override
  State<CardeReserve> createState() => _CardeReserveState();
}

class _CardeReserveState extends State<CardeReserve> {
  String checkInDate = DateTime.now().toIso8601String();
  String checkOutDate = DateTime.now().add(const Duration(days: 7)).toIso8601String();
  final guestController = TextEditingController(text: '1');
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.property.startDate.isNotEmpty) checkInDate = widget.property.startDate;
    if (widget.property.endDate.isNotEmpty) checkOutDate = widget.property.endDate;
    if (widget.property.reservationGuestNumber > 0) {
      guestController.text = widget.property.reservationGuestNumber.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
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
    child: Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: DateField(
                  date: checkInDate,
                  start: widget.property.startDate,
                  end: widget.property.endDate,
                  title: context.l10n.checkIn.trim(),
                  // isEnabled: widget.property.reservationId.isEmpty,
                  onDateSelected: (date) {
                    final selectedDate = DateTime.tryParse(date) ?? DateTime.now();
                    final checkOut = DateTime.tryParse(checkOutDate) ?? selectedDate.add(const Duration(days: 1));
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
                  start: widget.property.startDate,
                  end: widget.property.endDate,
                  title: context.l10n.checkOut.trim(),
                  // isEnabled: widget.property.reservationId.isEmpty,
                  onDateSelected: (date) {
                    final selectedDate = DateTime.tryParse(date) ?? DateTime.now();
                    final checkIn = DateTime.tryParse(checkInDate) ?? selectedDate.subtract(const Duration(days: 1));
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
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: context.l10n.guestsNoLabel,
                color: AppColors.secondTextColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 4),
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  controller: guestController,
                  keyboardType: TextInputType.number,
                  // enabled: widget.property.reservationId.isEmpty,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) return context.l10n.pleaseEnterNumberOfGuests;
                    final guests = int.tryParse(value);
                    if (guests == null || guests <= 0) return context.l10n.enterValidNumberOfGuests;
                    if (guests > widget.property.guestNumber) {
                      return context.l10n.maxGuestsIs(widget.property.guestNumber.toString());
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: buildOutlineInputBorder(5),
                    focusedBorder: buildOutlineInputBorder(5),
                    hintText: context.l10n.guestCountHint,
                    hintStyle: const TextStyle(color: AppColors.grayTextColor, fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) return;
                // if (widget.property.reservationId.isEmpty) {
                showReseverDialoge(context, widget.property, checkInDate, checkOutDate, guestController.text.trim());
                // } else {
                //   Navigator.pop(context);
                //   getIt<HomeCubit>().updateCurrentScreenIndex(2);
                // }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                //padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              ),
              child: TextWidget(
                text: context.l10n.reserveLabel,
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
