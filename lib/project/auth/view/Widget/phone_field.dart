import 'package:country_picker/country_picker.dart';
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
  Country _selectedCountry = Country(
    displayNameNoCountryCode: 'Saudi Arabia',
    countryCode: 'SA',
    phoneCode: '966',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Saudi Arabia',
    example: '512 345 678',
    displayName: 'Saudi Arabia (SA) [+966]',
    e164Key: '966-SA-0',
  );

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
        InkWell(
          onTap: () {
            showCountryPicker(
              context: context,
              showPhoneCode: true,
              favorite: const ['SA', 'EG'],
              countryListTheme: CountryListThemeData(
                flagSize: 24,
                inputDecoration: InputDecoration(
                  labelText: 'Search',
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(),
                ),
              ),
              onSelect: (Country country) {
                setState(() => _selectedCountry = country);
                final fullNumber = '+${country.phoneCode}${phoneController.text.trim()}';
                widget.onChanged(fullNumber);
              },
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_selectedCountry.flagEmoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 6),
              Text('+${_selectedCountry.phoneCode}', style: const TextStyle(fontWeight: FontWeight.w600)),
              const Icon(Icons.keyboard_arrow_down, size: 18),
            ],
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
            onChanged: (value) => widget.onChanged('+${_selectedCountry.phoneCode}${value.trim()}'),
          ),
        ),
      ],
    ),
  );
}
