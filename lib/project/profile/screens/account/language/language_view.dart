import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/localization/localization_cubit.dart';
import '../../../../../locator.dart';
import 'wideget_language.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: BlocBuilder<LocalizationCubit, Locale?>(
        bloc: getIt<LocalizationCubit>(),
        builder: (context, locale) {
          final effectiveCode = (locale?.languageCode) ?? Localizations.localeOf(context).languageCode;
          final isEnglishSelected = effectiveCode == 'en';
          final isArabicSelected = effectiveCode == 'ar';
          return LanguageContent(
            isEnglishSelected: isEnglishSelected,
            isArabicSelected: isArabicSelected,
            onLanguageToggle: () {
              final next = isEnglishSelected ? const Locale('ar') : const Locale('en');
              getIt<LocalizationCubit>().setLocale(next);
            },
          );
        },
      ),
    );
  }
}
