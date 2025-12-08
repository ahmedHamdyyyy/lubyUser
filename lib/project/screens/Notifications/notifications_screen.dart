// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/constants/constance.dart';
import '../../../core/utils/utile.dart';
import '../../../locator.dart';
import '../../Home/Widget/signin_placeholder.dart';
import '../../Home/cubit/home_cubit.dart';
import 'all_widget_notfication.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  void _fetchNotifications() {
    _isLoggedIn = getIt<HomeCubit>().state.isSignedIn;
    if (!_isLoggedIn) return;
    WidgetsBinding.instance.addPostFrameCallback((_) => getIt<HomeCubit>().loadNotifications());
  }

  @override
  void dispose() {
    getIt<HomeCubit>().initNotifications();
    super.dispose();
  }

  void _login() {
    setState(() => _isLoggedIn = true);
    _fetchNotifications();
  }

  @override
  Widget build(BuildContext context) => BlocSelector<HomeCubit, HomeState, bool>(
    selector: (state) => state.isSignedIn,
    builder:
        (context, isSignedIn) => Scaffold(
          backgroundColor: Colors.white,
          appBar: notificationsListAppBar(context),
          body: SingleChildScrollView(
            child: BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state.loadNotificationsStatus == Status.loading || state.readNotificationStatus == Status.loading) {
                  Utils.loadingDialog(context);
                } else if (state.loadNotificationsStatus == Status.success ||
                    state.readNotificationStatus == Status.success) {
                  Navigator.pop(context);
                } else if (state.loadNotificationsStatus == Status.error || state.readNotificationStatus == Status.error) {
                  Navigator.pop(context);
                  Utils.errorDialog(context, state.msg);
                }
              },
              builder: (context, state) {
                if (!isSignedIn) return SigninPlaceholder(onLoginSuccessfuly: _login);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NotificationsListTitle(
                      onTap: () {
                        // setState(() {
                        //   hasNotifications = !hasNotifications;
                        // });
                      },
                    ),
                    state.notifications.isNotEmpty
                        ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(16),
                          itemCount: state.notifications.length,
                          itemBuilder: (context, index) {
                            final notification = state.notifications[index];
                            return NotificationItem(notification: notification);
                          },
                        )
                        : const EmptyNotificationsState(),
                  ],
                );
              },
            ),
          ),
        ),
  );
}
