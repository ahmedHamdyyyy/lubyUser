import 'package:flutter/material.dart';

import '../../../../config/colors/colors.dart';
import '../../../../config/widget/helper.dart';

class DateField extends StatefulWidget {
  const DateField({
    super.key,
    required this.date,
    required this.onDateSelected,
    this.isEnabled = true,
    required this.title,
    required this.start,
    required this.end,
  });
  final String date;
  final Function(String) onDateSelected;
  final bool isEnabled;
  final String title;
  final String start, end;
  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  late String date;
  @override
  void initState() {
    super.initState();
    date = widget.date;
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextWidget(text: widget.title, color: AppColors.secondTextColor, fontSize: 12, fontWeight: FontWeight.w500),
      const SizedBox(height: 4),
      GestureDetector(
        onTap: () async {
          if (!widget.isEnabled) return;
          final selected = await showDatePicker(
            context: context,
            firstDate: widget.start.isNotEmpty ? DateTime.tryParse(widget.start) ?? DateTime.now() : DateTime.now(),
            lastDate:
                widget.end.isNotEmpty
                    ? DateTime.tryParse(widget.end) ?? DateTime.now().add(const Duration(days: 365))
                    : DateTime.now().add(const Duration(days: 365)),
          );
          if (selected == null) return;
          date = selected.toIso8601String();
          setState(() {});
          widget.onDateSelected(date);
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: widget.isEnabled ? AppColors.grayTextColor : AppColors.lightGray),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Text(date.split('T').first.replaceAll('-', '/').split('/').reversed.join('/')),
        ),
      ),
    ],
  );
}
