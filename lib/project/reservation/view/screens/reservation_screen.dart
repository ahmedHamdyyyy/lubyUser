import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/constants/constance.dart';
import '../../../../../locator.dart';
import '../../../models/activity.dart';
import '../../../models/reversation.dart';
import '../../cubit/cubit.dart';
import '../widgets/all_wisget_reservation.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});
  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  bool isCurrentReservations = true;
  final _scrollController = ScrollController();
  bool _isLoadingMore = false;
  @override
  void initState() {
    getIt<ReservationsCubit>().getReservations(
      isCurrentReservations ? ReservationStatus.pending : ReservationStatus.approved,
    );

    _handleFetchModeItems();
    super.initState();
  }

  void _handleFetchModeItems() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        getIt<ReservationsCubit>().getReservations(
          isCurrentReservations ? ReservationStatus.pending : ReservationStatus.approved,
          fetchNext: true,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              return buildHotelReservationCardCurrentReservation(
                                context: context,
                                reservation: properties[index],
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
                              final reservationActivity = reservation.item as ActivityModel;
                              return buildActivityCardCurrentReservation(
                                persons: reservation.guestNumber,
                                title: reservationActivity.name,
                                date: reservation.checkInDate,
                                location: reservationActivity.address.formattedAddress,
                                imageUrl: reservationActivity.medias.first,
                                onViewDetails: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => ActivityDetailsScreen(activity: reservationActivity)),
                                  // );
                                },
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
  }

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
