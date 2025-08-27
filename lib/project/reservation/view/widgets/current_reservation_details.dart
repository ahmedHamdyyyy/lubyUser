// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../../../models/reversation.dart';
import 'all_wisget_reservation.dart';

class CurrentReservationDetailsScreen extends StatelessWidget {
  const CurrentReservationDetailsScreen({super.key, required this.reservation});
  final ReservationModel reservation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: CurrentReservationDetailsContent(reservation: reservation));
  }
}
