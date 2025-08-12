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
  Widget build(BuildContext context) {
    getIt<ReservationsCubit>().getReservations(
      isCurrentReservations ? ReservationStatus.pending : ReservationStatus.approved,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          reservationScreenAppBar(context),
          const SizedBox(height: 22),
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 16),
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
                    onTap: () {
                      setState(() {
                        isCurrentReservations = true;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: buildTabButton(
                    text: 'Last Reservations',
                    isSelected: !isCurrentReservations,
                    onTap: () {
                      setState(() {
                        isCurrentReservations = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ReservationsCubit, ReservationsState>(
              builder: (context, state) {
                if (state.getReservationsStatus == Status.loading && state.reservations.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                final properties = state.reservations.where((r) => r.type == ReservationType.property).toList();
                if (properties.isNotEmpty) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: properties.length,
                    itemBuilder: (context, index) {
                      return buildHotelReservationCardCurrentReservation(context: context, reservation: properties[index]);
                    },
                  );
                }
                final activities = state.reservations.where((r) => r.type == ReservationType.activity).toList();
                if (activities.isNotEmpty) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: activities.length,
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
                  );
                }
                return SizedBox.shrink();
                // children:
                //     isCurrentReservations
                //         ? [
                //           ,
                //           buildCurrentReservationContainer(
                //             context: context,
                //             hotelImageUrl: 'assets/images/image6.png',
                //             hotelTitle: 'Studio - 5 Night',
                //             hotelLocation: 'Riyadh - District Name',
                //             checkInDate: '14/10/2024',
                //             checkOutDate: '19/10/2024',
                //             activityImageUrl: 'assets/images/image7.png',
                //             activityTitle: 'Activity Name',
                //             activityLocation: 'Riyadh - District Name',
                //             activityPersons: 2,
                //             activityDate: '14/10/2024',
                //             onViewDetails: () {
                //               Navigator.push(
                //                 context,
                //                 MaterialPageRoute(builder: (context) => CurretReservationDetailsScreen()),
                //               );
                //             },
                //           ),
                //         ]
                //         : [
                //           // Last Reservations
                //           Column(
                //             children: [
                //               Container(
                //                 margin: const EdgeInsets.only(bottom: 16),
                //                 decoration: BoxDecoration(
                //                   color: Colors.white,
                //                   borderRadius: BorderRadius.circular(12),
                //                   border: Border.all(color: AppColors.primary),
                //                 ),
                //                 child: buildHotelReservationCardLastReservation(
                //                   imageUrl: 'assets/images/image6.png',
                //                   title: 'Studio - 5 Night',
                //                   location: 'Riyadh - District Name',
                //                   checkInDate: '14/10/2024',
                //                   checkOutDate: '19/10/2024',
                //                   onViewDetails: () {
                //                     Navigator.push(
                //                       context,
                //                       MaterialPageRoute(builder: (context) => CurretReservationDetailsScreen2()),
                //                     );
                //                   },
                //                 ),
                //               ),
                //               Container(
                //                 padding: const EdgeInsets.only(top: 16),
                //                 decoration: BoxDecoration(
                //                   color: Colors.white,
                //                   borderRadius: BorderRadius.circular(12),
                //                   border: Border.all(color: AppColors.primary),
                //                 ),
                //                 child: buildActivityCardLastReservation(
                //                   imageUrl: 'assets/images/image7.png',
                //                   title: 'Activity Name',
                //                   location: 'Riyadh - District Name',
                //                   persons: 2,
                //                   date: '14/10/2024',
                //                   onViewDetails: () {
                //                     Navigator.push(
                //                       context,
                //                       MaterialPageRoute(builder: (context) => CurretReservationDetailsScreen2()),
                //                     );
                //                   },
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}
