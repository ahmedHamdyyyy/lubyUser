import 'package:flutter/material.dart';
import 'wideget_language.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageView();
}

class _LanguageView extends State<LanguageView> {
  bool _isEnglishSelected = true;
  bool _isArabicSelected = false;

  void _toggleLanguage() {
    setState(() {
      _isEnglishSelected = !_isEnglishSelected;
      _isArabicSelected = !_isArabicSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: LanguageContent(
        isEnglishSelected: _isEnglishSelected,
        isArabicSelected: _isArabicSelected,
        onLanguageToggle: _toggleLanguage,
      ),
    );
  }
}
