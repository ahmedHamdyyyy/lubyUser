import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../models/reversation.dart';
import '../data/repository.dart';

part 'state.dart';

class ReservationsCubit extends Cubit<ReservationsState> {
  ReservationsCubit(this._repository) : super(const ReservationsState());
  final ReservationsRepository _repository;
  bool _hasNextPage = false;

  void getReservations(ReservationStatus status, {bool fetchNext = false}) async {
    if (fetchNext && !_hasNextPage) return;
    emit(state.copyWith(getReservationsStatus: Status.loading));
    try {
      final reservationsData = await _repository.getReservations(fetchNext, status);
      _hasNextPage = reservationsData.hasNextPage;
      emit(
        state.copyWith(
          getReservationsStatus: Status.success,
          reservations:
              fetchNext ? [...state.reservations, ...reservationsData.reservations] : reservationsData.reservations,
        ),
      );
    } catch (e) {
      emit(state.copyWith(getReservationsStatus: Status.error, message: e.toString()));
    }
  }

  void createReservation(ReservationModel reservation) async {
    emit(state.copyWith(createReservationStatus: Status.loading));
    try {
      await _repository.createReservation(reservation);
      emit(state.copyWith(createReservationStatus: Status.success));
    } catch (e) {
      emit(state.copyWith(createReservationStatus: Status.error, message: e.toString()));
    }
  }

  void updateReservation(ReservationModel reservation) async {
    emit(state.copyWith(updateReservationStatus: Status.loading));
    try {
      await _repository.updateReservation(reservation);
      emit(state.copyWith(updateReservationStatus: Status.success));
    } catch (e) {
      emit(state.copyWith(updateReservationStatus: Status.error, message: e.toString()));
    }
  }

  void removeReservation(String id) async {
    emit(state.copyWith(removeReservationStatus: Status.loading));
    try {
      await _repository.removeReservation(id);
      emit(
        state.copyWith(
          removeReservationStatus: Status.success,
          reservations: [...state.reservations.where((reservation) => reservation.id != id)],
        ),
      );
    } catch (e) {
      emit(state.copyWith(removeReservationStatus: Status.error, message: e.toString()));
    }
  }

  Future<({String message, bool isSuccess})> initiatePayment(String reservationId) async {
    try {
      final paymentLink = await _repository.payment(reservationId);
      return (message: paymentLink, isSuccess: true);
    } catch (e) {
      emit(state.copyWith(message: e.toString()));
      return (message: e.toString(), isSuccess: false);
    }
  }

  Future<bool> checkPaymentStatus(String reservationId) async {
    try {
      final reservation = await _repository.getReservation(reservationId);
      if (reservation.status == ReservationStatus.completed) {
        emit(state.copyWith(reservations: state.reservations.map((r) => r.id == reservation.id ? reservation : r).toList()));
        return true;
      }
      return false;
    } catch (e) {
      emit(state.copyWith(message: e.toString()));
      return false;
    }
  }

  void initStatus() {
    emit(
      state.copyWith(
        createReservationStatus: Status.initial,
        updateReservationStatus: Status.initial,
        removeReservationStatus: Status.initial,
      ),
    );
  }
}
