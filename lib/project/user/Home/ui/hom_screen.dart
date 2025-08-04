// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:luby2/project/user/Home/Widget/widget_home.dart' show buildBottomNavigationBar;

import '../../../../locator.dart';
import '../../User/screens/Conversations/conversations_screen.dart';
import '../../User/screens/account/account_info/account.dart';
import '../../User/screens/reservation/reservation_screen.dart';
import '../../favorites/view/favourite2.dart';
import '../cubit/home_cubit.dart';
import 'home_main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final screen = [HomeScreenMain(), Favorite2Screen(), ReservationScreen(), ConversationScreen(), AccountScreen()];
  void updateCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    getIt<HomeCubit>().fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          updateCurrentIndex(0);
        }
      },

      child: Scaffold(
        body: screen[_currentIndex],
        bottomNavigationBar: buildBottomNavigationBar(currentIndex: _currentIndex, onTap: updateCurrentIndex),
      ),
    );
  }
}
