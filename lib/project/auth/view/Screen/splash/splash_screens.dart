// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:luby2/project/Home/ui/home_screen.dart';

import 'all_widget_onporsing.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  final PageController _pageController = PageController();

  List<Map<String, String>> _buildSplashData(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    if (isAr) {
      return [
        {
          "image": "assets/images/image2.png",
          "title": "اكتشف الإقامات والأنشطة",
          "description": "استكشف أفضل الإقامات والأنشطة الفريدة في أنحاء السعودية. احجز بسهولة وبأسعار واضحة.",
        },
        {
          "image": "assets/images/image3.png",
          "title": "حجز سلس ومدفوعات آمنة",
          "description": "تواريخ مرنة، تأكيد فوري، وخيارات دفع موثوقة تمنحك راحة البال.",
        },
        {
          "image": "assets/images/image4.png",
          "title": "تجربة مُصممة لك",
          "description": "فلاتر ذكية، المفضلة، وتحديثات لحظية لتخطيط رحلتك بدقة.",
        },
      ];
    } else {
      return [
        {
          "image": "assets/images/image2.png",
          "title": "Discover Stays & Adventures",
          "description":
              "Explore curated homes and unique activities across Saudi Arabia. Book fast with transparent pricing.",
        },
        {
          "image": "assets/images/image3.png",
          "title": "Seamless Booking, Secure Payments",
          "description": "Flexible dates, instant confirmations, and trusted payment options for peace of mind.",
        },
        {
          "image": "assets/images/image4.png",
          "title": "Tailored For You",
          "description": "Smart filters, favorites, and real‑time updates to plan perfectly.",
        },
      ];
    }
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
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false,
          );
        },
      ),
    );
  }
}
