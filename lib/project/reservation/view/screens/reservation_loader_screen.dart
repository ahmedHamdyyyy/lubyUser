import 'package:flutter/material.dart';

import '../../../../core/services/api_services.dart';
import '../../../../locator.dart';
import '../../../models/reversation.dart';
import '../../cubit/cubit.dart';
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
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    try {
      setState(() {
        _loading = true;
        _error = null;
      });
      final repo = ReservationsRepository(ReservationsData(getIt<ApiService>()));
      // Avoid hanging forever: enforce a timeout
      final reservation = await repo
          .getReservation(widget.reservationId)
          .timeout(const Duration(seconds: 15), onTimeout: () => throw Exception('Request timed out'));
      if (!mounted) return;
      setState(() {
        _reservation = reservation;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_error!, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(onPressed: _fetch, child: const Text('Retry')),
                    const SizedBox(width: 12),
                    OutlinedButton(onPressed: () => Navigator.of(context).maybePop(), child: const Text('Back')),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    if (_reservation == null) {
      return Scaffold(appBar: AppBar(leading: const BackButton()), body: const Center(child: Text('Reservation not found')));
    }
    getIt<ReservationsCubit>().setReservation(_reservation!);
    return ReservationScreen();
  }
}
