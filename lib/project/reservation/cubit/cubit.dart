import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../models/reversation.dart';
import '../data/repository.dart';

part 'state.dart';

enum ReservationsFilterType { draft, current, last }

class ReservationsCubit extends Cubit<ReservationsState> {
  ReservationsCubit(this._repository) : super(const ReservationsState());
  final ReservationsRepository _repository;
  bool _hasNextPage = false;

  void getReservations(ReservationsFilterType filter, {bool fetchNext = false}) async {
    if (fetchNext && !_hasNextPage) return;
    emit(state.copyWith(getReservationsStatus: Status.loading));
    try {
      final reservationsData = await _repository.getReservations(fetchNext, filter);
      _hasNextPage = reservationsData.hasNextPage;
      emit(
        state.copyWith(
          getReservationsStatus: Status.success,
          reservations:
              fetchNext ? [...state.reservations, ...reservationsData.reservations] : reservationsData.reservations,
        ),
      );
    } catch (e) {
      emit(state.copyWith(getReservationsStatus: Status.error, message: AppConst.normalizeError(e)));
    }
  }

  void createReservation(ReservationModel reservation) async {
    emit(state.copyWith(createReservationStatus: Status.loading));
    try {
      final created = await _repository.createReservation(reservation);
      emit(state.copyWith(createReservationStatus: Status.success, message: created.id));
    } catch (e) {
      emit(state.copyWith(createReservationStatus: Status.error, message: AppConst.normalizeError(e)));
    }
  }

  void updateReservation(ReservationModel reservation) async {
    emit(state.copyWith(updateReservationStatus: Status.loading));
    try {
      final updated = await _repository.updateReservation(reservation);
      emit(state.copyWith(updateReservationStatus: Status.success, message: updated.id));
    } catch (e) {
      emit(state.copyWith(updateReservationStatus: Status.error, message: AppConst.normalizeError(e)));
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
      emit(state.copyWith(removeReservationStatus: Status.error, message: AppConst.normalizeError(e)));
    }
  }

  void initiatePayment() async {
    emit(state.copyWith(paymentStatus: PaymentStatus.loading, paymentUrl: ''));
    try {
      final paymentLink = await _repository.payment(state.reservation.id);
      emit(
        state.copyWith(
          paymentStatus: PaymentStatus.paying,
          paymentUrl: paymentLink.replaceFirst('https://pay.', 'https://sandbox.'),
        ),
      );
    } catch (e) {
      emit(state.copyWith(paymentStatus: PaymentStatus.error, message: AppConst.normalizeError(e), paymentUrl: ''));
    }
  }

  void setPayingInitial() => emit(state.copyWith(paymentStatus: PaymentStatus.initial));

  void setReservation(ReservationModel reservation) => emit(state.copyWith(reservation: reservation));

  // void updateReservationStatus() async {
  //   try {
  //     final updatedList = state.reservations
  //         .map((r) => r.id == reservationId ? r.copyWith(status: status) : r)
  //         .toList(growable: false);
  //     emit(state.copyWith(reservations: updatedList));
  //   } catch (e) {
  //     emit(state.copyWith(message: e.toString()));
  //   }
  // }

  Future<bool> checkPaymentStatus() async {
    emit(state.copyWith(paymentStatus: PaymentStatus.loading, paymentUrl: ''));
    try {
      final reservation = await _repository.getReservation(state.reservation.id).timeout(const Duration(seconds: 12));
      if (reservation.status == ReservationStatus.completed) {
        emit(
          state.copyWith(
            reservations: state.reservations.where((r) => r.id != reservation.id).toList(),
            paymentStatus: PaymentStatus.success,
            reservation: reservation,
            paymentUrl: '',
          ),
        );
        return true;
      } else {
        emit(state.copyWith(paymentStatus: PaymentStatus.error, paymentUrl: ''));
        return false;
      }
    } catch (e) {
      emit(state.copyWith(message: AppConst.normalizeError(e), paymentStatus: PaymentStatus.error, paymentUrl: ''));
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
