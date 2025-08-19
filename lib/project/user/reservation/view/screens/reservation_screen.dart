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
  @override
  void initState() {
    getIt<ReservationsCubit>().getReservations(
      isCurrentReservations ? ReservationStatus.pending : ReservationStatus.approved,
    );
    super.initState();
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
                  return const Center(child: CircularProgressIndicator());
                }
                final properties = state.reservations.where((r) => r.type == ReservationType.property).toList();
                final activities = state.reservations.where((r) => r.type == ReservationType.activity).toList();
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Properties'),
                        SizedBox(height: 8),
                        if (properties.isEmpty)
                          Center(
                            child: Padding(padding: const EdgeInsets.all(16), child: const Text('No current reservations')),
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
                          Center(
                            child: Padding(padding: const EdgeInsets.all(16), child: const Text('No current reservations')),
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
                                location: reservationActivity.address,
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
}
