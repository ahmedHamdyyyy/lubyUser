import 'package:flutter/material.dart';
import '../../../../../../config/widget/helper.dart';

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
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 24,
              ),
              color: const Color(0xFF757575),
            ),
            const TextWidget(
              text: 'language',
              color: Color(0xFF757575),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
          child: TextWidget(
            text: 'Choose Your Language',
            color: Color(0xFF1C1C1C),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
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

  const LanguageOptionWidget({
    super.key,
    required this.isSelected,
    required this.languageName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
          onPressed: onTap,
          icon: isSelected
              ? const CircleAvatar(
                  backgroundColor: Color(0xFF262626),
                  radius: 12,
                  child: CircleAvatar(
                    backgroundColor: Color(0xFFFFFFFF),
                    radius: 11,
                  ),
                )
              : const CircleAvatar(
                  backgroundColor: Color(0xFF262626),
                  radius: 12,
                ),
          label: TextWidget(
            text: languageName,
            color: const Color(0xFF414141),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            alignment: Alignment.centerLeft,
          ),
        ),
      ],
    );
  }
}

// Language Options List
class LanguageOptionsList extends StatelessWidget {
  final bool isEnglishSelected;
  final bool isArabicSelected;
  final VoidCallback onLanguageToggle;

  const LanguageOptionsList({
    super.key,
    required this.isEnglishSelected,
    required this.isArabicSelected,
    required this.onLanguageToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LanguageOptionWidget(
          isSelected: isEnglishSelected,
          languageName: 'English',
          onTap: onLanguageToggle,
        ),
        LanguageOptionWidget(
          isSelected: isArabicSelected,
          languageName: 'اللغة العربية',
          onTap: onLanguageToggle,
        ),
      ],
    );
  }
}

// Main Language Content Widget
class LanguageContent extends StatelessWidget {
  final bool isEnglishSelected;
  final bool isArabicSelected;
  final VoidCallback onLanguageToggle;

  const LanguageContent({
    super.key,
    required this.isEnglishSelected,
    required this.isArabicSelected,
    required this.onLanguageToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LanguageHeader(),
        LanguageOptionsList(
          isEnglishSelected: isEnglishSelected,
          isArabicSelected: isArabicSelected,
          onLanguageToggle: onLanguageToggle,
        ),
      ],
    );
  }
}
