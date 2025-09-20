// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/constants/constance.dart';
import '../../../../../../core/services/cach_services.dart';
import '../../../../../../locator.dart';
import '../../../../Home/ui/hom_screen.dart';
import 'language_selection_screen.dart';

class LubyScreenSplash extends StatefulWidget {
  const LubyScreenSplash({super.key});

  @override
  State<LubyScreenSplash> createState() => _LubyScreenSplashState();
}

class _LubyScreenSplashState extends State<LubyScreenSplash> {
  final isLoggedIn = (getIt<CacheService>().storage.getString(AppConst.accessToken) ?? '').isNotEmpty;
  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }

  void _handleNavigation() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => isLoggedIn ? const HomeScreen() : const LanguageSelectionScreen()),
      );
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
