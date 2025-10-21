// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:luby2/l10n/app_localizations.dart';

import '../auth/sign_in.dart';
import 'all_widget_onporsing.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  final PageController _pageController = PageController();

  List<Map<String, String>> _buildSplashData(BuildContext context) {
    final t = AppLocalizations.of(context);
    return [
      {
        "image": "assets/images/image2.png",
        "title": t.onboardingExploreSaudiTitle,
        "description": t.onboardingExploreSaudiDescription,
      },
      {
        "image": "assets/images/image3.png",
        "title": t.onboardingExploreSaudiTitle,
        "description": t.onboardingExploreSaudiDescription,
      },
      {
        "image": "assets/images/image4.png",
        "title": t.onboardingExploreSaudiTitle,
        "description": t.onboardingExploreSaudiDescription,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreensContent(
        pageController: _pageController,
        splashData: _buildSplashData(context),
        onSkip: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SignInScreen()),
            (route) => false,
          );
        },
      ),
    );
  }
}
