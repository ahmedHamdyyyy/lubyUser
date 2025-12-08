import 'package:flutter/material.dart';
import 'package:luby2/core/localization/l10n_ext.dart';

import '../../../../config/colors/colors.dart';

class PhoneField extends StatefulWidget {
  const PhoneField({super.key, required this.onChanged});
  final void Function(String) onChanged;
  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  final phoneController = TextEditingController();
  String _selectedCountryCode = '+966';

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.blackColor.withAlpha(150)),
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    ),
    child: Row(
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            alignment: AlignmentDirectional.centerEnd,
            value: _selectedCountryCode,
            icon: SizedBox.shrink(),
            items: ['+20', '+966'].map((code) => DropdownMenuItem(value: code, child: Text(code))).toList(),
            onChanged: (value) {
              if (value == null) return;
              setState(() => _selectedCountryCode = value);
              widget.onChanged(value + phoneController.text.trim());
              print(value + phoneController.text.trim());
            },
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: context.l10n.phoneNumberLabel,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            controller: phoneController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return context.l10n.invalidGuestNumber;
              }
              return null;
            },
            onChanged: (value) => widget.onChanged(_selectedCountryCode + value.trim()),
          ),
        ),
      ],
    ),
  );
}
