import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../../core/localization/localization_cubit.dart';
import 'all_widget_onporsing.dart';
import 'first_splash_screen.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.primary,
    body: LanguageSelectionScreenContent(
      onSelectEnglish: () async {
        await context.read<LocalizationCubit>().setLocale(const Locale('en'));
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FirstSplashScreen()));
      },
      onSelectArabic: () async {
        await context.read<LocalizationCubit>().setLocale(const Locale('ar'));
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FirstSplashScreen()));
      },
    ),
  );
}
