// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'all_wisget_reservation.dart';

class CurretReservationDetailsScreen extends StatelessWidget {
  const CurretReservationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CurrentReservationDetailsContent(),
    );
  }
}
