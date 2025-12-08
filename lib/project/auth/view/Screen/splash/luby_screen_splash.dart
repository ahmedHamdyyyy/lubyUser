// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../Home/ui/home_screen.dart';

class LubyScreenSplash extends StatefulWidget {
  const LubyScreenSplash({super.key});
  @override
  State<LubyScreenSplash> createState() => _LubyScreenSplashState();
}

class _LubyScreenSplashState extends State<LubyScreenSplash> {
  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }

  // void _handleNavigation() {
  // final isLoggedIn = (getIt<CacheService>().storage.getString(AppConst.accessToken) ?? '').isNotEmpty;
  //   Future.delayed(const Duration(seconds: 3), () {
  //     if (!mounted) return;
  //     // If something (like a notification) already pushed a route, don't override it
  //     if (Navigator.of(context).canPop()) return;
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => isLoggedIn ? const HomeScreen() : const LanguageSelectionScreen()),
  //     );
  //   });
  // }

  void _handleNavigation() {
    // final isLoggedIn = (getIt<CacheService>().storage.getString(AppConst.accessToken) ?? '').isNotEmpty;
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      if (Navigator.of(context).canPop()) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(child: Image.asset('assets/images/logo1.png', width: 150.w)),
    );
  }
}
