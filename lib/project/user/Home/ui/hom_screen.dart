// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luby2/project/user/Home/Widget/widget_home.dart' show buildBottomNavigationBar;

import '../../../../locator.dart';
import '../../User/screens/Conversations/conversations_screen.dart';
import '../../User/screens/account/account_info/account.dart';
import '../../activities/cubit/cubit.dart';
import '../../favorites/view/favourite2.dart';
import '../../reservation/view/screens/reservation_screen.dart';
import '../cubit/home_cubit.dart';
import 'home_main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final screen = [HomeScreenMain(), Favorite2Screen(), ReservationScreen(), ConversationScreen(), AccountScreen()];

  @override
  void initState() {
    getIt<HomeCubit>().fetchUser();

    getIt<HomeCubit>().getProperties();
    getIt<ActivitiesCubit>().getActivities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) getIt<HomeCubit>().updateCurrentScreenIndex(0);
      },
      child: BlocSelector<HomeCubit, HomeState, int>(
        selector: (state) => state.currentScreenIndex,
        builder: (context, currentScreenIndex) {
          return Scaffold(
            body: screen[currentScreenIndex],
            bottomNavigationBar: buildBottomNavigationBar(
              currentIndex: currentScreenIndex,
              onTap: getIt<HomeCubit>().updateCurrentScreenIndex,
            ),
          );
        },
      ),
    );
  }
}
