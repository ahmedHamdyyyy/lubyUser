import 'package:flutter/material.dart';
// Import widget file
import 'wideget_about.dart';
// Uncomment if needed for bottom navigation
// import '../../propreties/widgets/bottom_nav_bar_widget.dart';

class AboutLobyViewUser extends StatelessWidget {
  const AboutLobyViewUser({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: AboutLobyBody(),
      ),
      //bottomNavigationBar: BottomNavBarWidget(),
    );
  }
}
