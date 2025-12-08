import 'package:flutter/material.dart';

import '../../../../../config/widget/helper.dart';
import '../../../../core/localization/l10n_ext.dart';

// Language Header Widget
class LanguageHeader extends StatelessWidget {
  const LanguageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 22),
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new, size: 24),
              color: const Color(0xFF757575),
            ),
            TextWidget(
              text: context.l10n.selectYourLanguageEnglishTitle,
              color: const Color(0xFF757575),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ],
    );
  }
}

// Language Option Widget
class LanguageOptionWidget extends StatelessWidget {
  final bool isSelected;
  final String languageName;
  final VoidCallback onTap;

  const LanguageOptionWidget({super.key, required this.isSelected, required this.languageName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
          onPressed: onTap,
          icon:
              isSelected
                  ? const CircleAvatar(backgroundColor: Color(0xFF262626), radius: 12)
                  : const CircleAvatar(
                    backgroundColor: Color(0xFF262626),
                    radius: 12,
                    child: CircleAvatar(backgroundColor: Color(0xFFFFFFFF), radius: 11),
                  ),
          label: TextWidget(text: languageName, color: const Color(0xFF414141), fontSize: 16, fontWeight: FontWeight.w400),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            alignment: Alignment.centerLeft,
          ),
        ),
      ],
    );
  }
}

// Language Options List
class LanguageOptionsList extends StatelessWidget {
  final String selectedLanguageCode;
  final VoidCallback onLanguageToggle;

  const LanguageOptionsList({super.key, required this.selectedLanguageCode, required this.onLanguageToggle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LanguageOptionWidget(
          isSelected: selectedLanguageCode == 'en',
          languageName: context.l10n.english,
          onTap: () {
            if (selectedLanguageCode != 'en') onLanguageToggle();
          },
        ),
        LanguageOptionWidget(
          isSelected: selectedLanguageCode == 'ar',
          languageName: context.l10n.arabic,
          onTap: () {
            if (selectedLanguageCode != 'ar') onLanguageToggle();
          },
        ),
      ],
    );
  }
}

// Main Language Content Widget
class LanguageContent extends StatelessWidget {
  final String selectedLanguageCode;
  final VoidCallback onLanguageToggle;

  const LanguageContent({super.key, required this.selectedLanguageCode, required this.onLanguageToggle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LanguageHeader(),
        LanguageOptionsList(selectedLanguageCode: selectedLanguageCode, onLanguageToggle: onLanguageToggle),
      ],
    );
  }
}
