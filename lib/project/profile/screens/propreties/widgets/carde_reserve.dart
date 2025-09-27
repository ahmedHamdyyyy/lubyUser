import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/widget/helper.dart';
import '../../../../models/property.dart';
import 'show_reserve_dialoge.dart';

class CardeReserve extends StatefulWidget {
  const CardeReserve({super.key, required this.property});
  final PropertyModel property;
  @override
  State<CardeReserve> createState() => _CardeReserveState();
}

class _CardeReserveState extends State<CardeReserve> {
  final checkInController = TextEditingController(), checkOutController = TextEditingController();
  final guestController = TextEditingController(text: '1');
  final formKey = GlobalKey<FormState>();
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextWidget(
                      text: 'Check in',
                      color: AppColors.secondTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 40,
                      width: 144,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        keyboardType: TextInputType.datetime,
                        controller: checkInController,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Please enter check-in date';
                          if (!RegExp(r'^\d{1,2}/\d{1,2}/\d{4}$').hasMatch(value)) return 'Enter date in DD/MM/YYYY format';
                          final dateParts = value.split('/');
                          final day = int.tryParse(dateParts[0]);
                          final month = int.tryParse(dateParts[1]);
                          final year = int.tryParse(dateParts[2]);
                          if (day == null || month == null || year == null) return 'Invalid date components';
                          final date = DateTime(year, month, day);
                          if (date.isBefore(DateTime.now())) return 'Check-in date must be in the future';
                          final startDate = DateTime.tryParse(widget.property.startDate) ?? DateTime.now();
                          final endDate = DateTime.tryParse(widget.property.endDate) ?? DateTime.now();
                          if (date.isBefore(startDate) || date.isAfter(endDate)) {
                            return 'Date must be within property availability';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          enabledBorder: buildOutlineInputBorder(5),
                          focusedBorder: buildOutlineInputBorder(5),
                          hintText: widget.property.startDate
                              .split('T')
                              .first
                              .replaceAll('-', '/')
                              .split('/')
                              .reversed
                              .join('/'),
                          hintStyle: const TextStyle(
                            color: AppColors.grayTextColor,
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
                      color: AppColors.secondTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 40,
                      width: 144,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        keyboardType: TextInputType.datetime,
                        controller: checkOutController,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Please enter check-in date';
                          if (!RegExp(r'^\d{1,2}/\d{1,2}/\d{4}$').hasMatch(value)) return 'Enter date in DD/MM/YYYY format';
                          final dateParts = value.split('/');
                          final day = int.tryParse(dateParts[0]);
                          final month = int.tryParse(dateParts[1]);
                          final year = int.tryParse(dateParts[2]);
                          if (day == null || month == null || year == null) return 'Invalid date components';
                          final date = DateTime(year, month, day);
                          if (date.isBefore(DateTime.now())) return 'Check-in date must be in the future';
                          final startDate = DateTime.tryParse(widget.property.startDate) ?? DateTime.now();
                          final endDate = DateTime.tryParse(widget.property.endDate) ?? DateTime.now();
                          if (date.isBefore(startDate) || date.isAfter(endDate)) {
                            return 'Date must be within property availability';
                          }
                          if (checkInController.text.isNotEmpty) {
                            final checkInParts = checkInController.text.split('/');
                            final checkInDay = int.tryParse(checkInParts[0]);
                            final checkInMonth = int.tryParse(checkInParts[1]);
                            final checkInYear = int.tryParse(checkInParts[2]);
                            if (checkInDay != null && checkInMonth != null && checkInYear != null) {
                              final checkInDate = DateTime(checkInYear, checkInMonth, checkInDay);
                              if (!date.isAfter(checkInDate)) return 'Check-out must be after check-in';
                            }
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          enabledBorder: buildOutlineInputBorder(5),
                          focusedBorder: buildOutlineInputBorder(5),
                          hintText: widget.property.endDate
                              .split('T')
                              .first
                              .replaceAll('-', '/')
                              .split('/')
                              .reversed
                              .join('/'),
                          hintStyle: const TextStyle(
                            color: AppColors.grayTextColor,
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
              const SizedBox(height: 4),
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  controller: guestController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter number of guests';
                    final guests = int.tryParse(value);
                    if (guests == null || guests <= 0) return 'Enter a valid number of guests';
                    if (guests > widget.property.guestNumber) {
                      return 'Max guests is ${widget.property.guestNumber}';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: buildOutlineInputBorder(5),
                    focusedBorder: buildOutlineInputBorder(5),
                    hintText: '2 Guests',
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
                showReseverDialoge(context, widget.property, checkInController, checkOutController, guestController);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                //padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              ),
              child: const TextWidget(text: 'Reserve', color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    ),
  );
}
