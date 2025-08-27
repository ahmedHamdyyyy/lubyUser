import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../models/reversation.dart';
import '../data/repository.dart';

part 'state.dart';

class ReservationsCubit extends Cubit<ReservationsState> {
  ReservationsCubit(this._repository) : super(const ReservationsState());
  final ReservationsRepository _repository;

  void getReservations(ReservationStatus status) async {
    emit(state.copyWith(getReservationsStatus: Status.loading));
    try {
      final reservations = await _repository.getReservations(status);
      emit(state.copyWith(getReservationsStatus: Status.success, reservations: reservations));
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
