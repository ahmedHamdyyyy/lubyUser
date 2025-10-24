import 'package:flutter/material.dart';

import '../../../../core/services/api_services.dart';
import '../../../../locator.dart';
import '../../../models/reversation.dart';
import '../../data/data.dart';
import '../../data/repository.dart';
import 'reservation_screen.dart';

class ReservationLoaderScreen extends StatefulWidget {
  const ReservationLoaderScreen({super.key, required this.reservationId});
  final String reservationId;

  @override
  State<ReservationLoaderScreen> createState() => _ReservationLoaderScreenState();
}

class _ReservationLoaderScreenState extends State<ReservationLoaderScreen> {
  ReservationModel? _reservation;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    try {
      final repo = ReservationsRepository(ReservationsData(getIt<ApiService>()));
      final reservation = await repo.getReservation(widget.reservationId);
      if (!mounted) return;
      setState(() => _reservation = reservation);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Scaffold(appBar: AppBar(leading: BackButton()), body: Center(child: Text(_error!)));
    }
    if (_reservation == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return ReservationScreen(reservation: _reservation!);
  }
}
