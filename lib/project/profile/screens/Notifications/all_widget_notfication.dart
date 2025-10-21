import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:luby2/locator.dart';
import 'package:luby2/project/Home/cubit/home_cubit.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/images/image_assets.dart';
import '../../../../../../config/widget/helper.dart';
import '../../../../../core/localization/l10n_ext.dart';
import '../../../../../core/utils/utile.dart';
import '../../../models/notification.dart';
import '../../../reservation/view/screens/reservations_screen.dart';

class NotificationDetailContent extends StatelessWidget {
  final Map<String, dynamic> notification;

  const NotificationDetailContent({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    String _formatDate(String? raw) {
      if (raw == null || raw.isEmpty) return '';
      final DateTime? parsed = Utils.parseDate(raw) ?? DateTime.tryParse(raw);
      if (parsed == null) return raw;
      final locale = Localizations.localeOf(context).toLanguageTag();
      return DateFormat.yMMMd(locale).format(parsed);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Notification title
          Text(
            context.l10n.notificationNameLabel,
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primary),
          ),
          SizedBox(height: 25),
          Text(
            context.l10n.helloName('Ahmed Hamdy'),
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.secondTextColor),
          ),
          const SizedBox(height: 10),
          Text(_formatDate(notification['date']), style: GoogleFonts.poppins(fontSize: 14, color: AppColors.grayTextColor)),
          const SizedBox(height: 25),

          // Notification content
          buildLongText(),

          const SizedBox(height: 130),
        ],
      ),
    );
  }

  // Detailed notification text
  Widget buildLongText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay lorem ipsum dolor sit amet, consecr text Diam habitant ',
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700], height: 1.5),
        ),
        const SizedBox(height: 12),
        Text(
          'Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay lorem ipsum dolor sit amet, consecr text Diam habitant.',
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700], height: 1.5),
        ),
        const SizedBox(height: 12),
        Text(
          'Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay lorem ipsum dolor sit amet.',
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700], height: 1.5),
        ),
      ],
    );
  }
}

class NotificationReservationContent extends StatelessWidget {
  final Map<String, dynamic> notification;

  const NotificationReservationContent({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    String _formatDate(String? raw) {
      if (raw == null || raw.isEmpty) return '';
      final DateTime? parsed = Utils.parseDate(raw) ?? DateTime.tryParse(raw);
      if (parsed == null) return raw;
      final locale = Localizations.localeOf(context).toLanguageTag();
      return DateFormat.yMMMd(locale).format(parsed);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Notification title
          Text(
            context.l10n.notificationNameLabel,
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primary),
          ),
          SizedBox(height: 25),
          Text(
            context.l10n.helloName('Ahmed Hamdy'),
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.secondTextColor),
          ),
          const SizedBox(height: 10),
          Text(_formatDate(notification['date']), style: GoogleFonts.poppins(fontSize: 14, color: AppColors.grayTextColor)),
          const SizedBox(height: 25),

          // Reservation confirmation message
          Text(
            context.l10n.reservationCompletedShort,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.grayTextColor,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 130),

          // Show reservation details button
          buildReservationDetailsButton(context),
        ],
      ),
    );
  }

  // Button to navigate to reservation details
  Widget buildReservationDetailsButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ReservationsScreen()));
        },
        child: Text(
          context.l10n.viewReservationDetails,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

// Common app bar for notification screens
PreferredSizeWidget notificationAppBar(BuildContext context) {
  return appBarPop(context, context.l10n.notificationAppBarTitle, AppColors.secondTextColor);
}

// App bar for the main notifications list screen
PreferredSizeWidget notificationsListAppBar(BuildContext context) {
  return appBarPop(context, context.l10n.notificationsListAppBarTitle, AppColors.primaryColor);
}

// Widget for the notifications list title
class NotificationsListTitle extends StatelessWidget {
  final VoidCallback onTap;

  const NotificationsListTitle({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
      child: InkWell(
        onTap: onTap,
        child: Text(
          context.l10n.yourNotifications,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.primary),
        ),
      ),
    );
  }
}

// Widget for empty notifications state
class EmptyNotificationsState extends StatelessWidget {
  const EmptyNotificationsState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 180),
          // Bell icon
          SvgPicture.asset(ImageAssets.noNotifications, height: 130, width: 130),
          const SizedBox(height: 20),
          // Empty notifications message
          Text(
            context.l10n.noNotificationsRightNow,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(color: AppColors.secondTextColor, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// Widget for a single notification item
class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!notification.isRead) getIt<HomeCubit>().readNotification(notification.id);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: notification.isRead ? AppColors.primary.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary),
        ),
        child: Row(
          children: [
            Image.asset(height: 100, width: 100, 'assets/images/image6.png', fit: BoxFit.cover),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.primary),
                  ),
                  const SizedBox(height: 4),
                  Text(notification.body, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.secondTextColor)),
                  const SizedBox(height: 4),
                  Text(
                    (() {
                      final String raw = notification.createdAt;
                      if (raw.isEmpty) return '';
                      final DateTime? parsed = Utils.parseDate(raw) ?? DateTime.tryParse(raw);
                      if (parsed == null) return raw;
                      final locale = Localizations.localeOf(context).toLanguageTag();
                      return DateFormat.yMMMd(locale).format(parsed);
                    })(),
                    style: TextStyle(fontSize: 14, color: AppColors.grayTextColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
