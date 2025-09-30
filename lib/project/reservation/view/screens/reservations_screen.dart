import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/constants/constance.dart';
import '../../../../../locator.dart';
import '../../../models/activity.dart';
import '../../../models/property.dart';
import '../../../models/reversation.dart';
import '../../cubit/cubit.dart';
import 'reservation_screen.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});
  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  bool isCurrentReservations = true;
  final _scrollController = ScrollController();
  bool _isLoadingMore = false;
  @override
  void initState() {
    getIt<ReservationsCubit>().getReservations(
      isCurrentReservations ? ReservationStatus.draft : ReservationStatus.completed,
    );

    _handleFetchModeItems();
    super.initState();
  }

  void _handleFetchModeItems() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        getIt<ReservationsCubit>().getReservations(
          isCurrentReservations ? ReservationStatus.draft : ReservationStatus.completed,
          fetchNext: true,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 66, bottom: 8),
          child: Text(
            'Reservation',
            style: GoogleFonts.poppins(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16, top: 0, right: 18, left: 18),
          child: Row(
            children: [
              Expanded(
                child: buildTabButton(
                  text: 'Current Reservations',
                  isSelected: isCurrentReservations,
                  onTap: () => setState(() => isCurrentReservations = true),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: buildTabButton(
                  text: 'Last Reservations',
                  isSelected: !isCurrentReservations,
                  onTap: () => setState(() => isCurrentReservations = false),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<ReservationsCubit, ReservationsState>(
            builder: (context, state) {
              if (state.getReservationsStatus == Status.loading) {
                WidgetsBinding.instance.addPostFrameCallback((_) => setState(() => _isLoadingMore = true));
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) => setState(() => _isLoadingMore = false));
              }
              final properties = state.reservations.where((r) => r.type == ReservationType.property).toList();
              final activities = state.reservations.where((r) => r.type == ReservationType.activity).toList();
              return Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Properties'),
                      SizedBox(height: 8),
                      if (properties.isEmpty)
                        _buildEmptyState(
                          icon: Icons.home_outlined,
                          title: 'No Property Reservations',
                          subtitle: 'You don\'t have any current property reservations.',
                          isCurrent: isCurrentReservations,
                        )
                      else
                        ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: properties.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            final reservation = properties[index];
                            final item = properties[index].item as PropertyModel;
                            return Card(
                              color: Colors.white,
                              elevation: 0,
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox.square(
                                        dimension: 135,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(5),
                                          child: FadeInImage.assetNetwork(
                                            placeholder: 'assets/images/IMAG.png',
                                            image: item.medias.first,
                                            height: 150,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        flex: 5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    item.type,
                                                    maxLines: 2,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400,
                                                      color: AppColors.primaryColor,
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed:
                                                      () => getIt<ReservationsCubit>().removeReservation(reservation.id),
                                                  icon: Icon(Icons.delete),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              item.address.formattedAddress,
                                              style: GoogleFonts.poppins(fontSize: 14, color: AppColors.grayTextColor),
                                            ),
                                            const SizedBox(height: 4),
                                            RichText(
                                              text: TextSpan(
                                                style: GoogleFonts.poppins(fontSize: 14, color: AppColors.secondTextColor),
                                                children: [
                                                  const TextSpan(
                                                    text: 'check in ',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 14,
                                                      color: AppColors.secondTextColor,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: reservation.checkInDate.substring(0, 10),
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      color: AppColors.grayTextColor,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            RichText(
                                              text: TextSpan(
                                                style: GoogleFonts.poppins(fontSize: 14, color: AppColors.secondTextColor),
                                                children: [
                                                  TextSpan(
                                                    text: 'check out ',
                                                    style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 14,
                                                      color: AppColors.secondTextColor,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: reservation.checkOutDate.substring(0, 10),
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      color: AppColors.grayTextColor,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ReservationScreen(reservation: reservation)),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                      minimumSize: Size(double.infinity, 35),
                                    ),
                                    child: const Text('View Reservation Details'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      SizedBox(height: 16),
                      Text('Activities'),
                      SizedBox(height: 8),
                      if (activities.isEmpty)
                        _buildEmptyState(
                          icon: Icons.sports_soccer_outlined,
                          title: 'No Activity Reservations',
                          subtitle: 'You don\'t have any current activity reservations.',
                          isCurrent: isCurrentReservations,
                        )
                      else
                        ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: activities.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            final reservation = activities[index];
                            final activity = reservation.item as ActivityModel;
                            return Card(
                              color: Colors.white,
                              elevation: 0,
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox.square(
                                        dimension: 135,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(5),
                                          child: FadeInImage.assetNetwork(
                                            placeholder: 'assets/images/IMAG.png',
                                            image: activity.medias.firstWhere((m) => !m.startsWith('mp4'), orElse: () => ''),
                                            height: 150,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        flex: 5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    activity.name,
                                                    maxLines: 2,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400,
                                                      color: AppColors.primaryColor,
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed:
                                                      () => getIt<ReservationsCubit>().removeReservation(reservation.id),
                                                  icon: Icon(Icons.delete),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              activity.address.formattedAddress,
                                              style: GoogleFonts.poppins(fontSize: 14, color: AppColors.grayTextColor),
                                            ),
                                            const SizedBox(height: 4),
                                            RichText(
                                              text: TextSpan(
                                                style: GoogleFonts.poppins(fontSize: 14, color: AppColors.secondTextColor),
                                                children: [
                                                  const TextSpan(
                                                    text: 'Date ',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 14,
                                                      color: AppColors.secondTextColor,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: activity.date.length < 10 ? '' : activity.date.substring(0, 10),
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      color: AppColors.grayTextColor,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ReservationScreen(reservation: reservation)),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                      minimumSize: Size(double.infinity, 35),
                                    ),
                                    child: const Text('View Reservation Details'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      if (_isLoadingMore)
                        Center(
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );

  Widget buildTabButton({required String text, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isCurrent,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 60, color: AppColors.primaryColor),
          SizedBox(height: 16),
          Text(title, style: GoogleFonts.poppins(color: AppColors.primaryColor, fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Text(
            subtitle,
            style: GoogleFonts.poppins(color: AppColors.primaryColor.withAlpha(180), fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
