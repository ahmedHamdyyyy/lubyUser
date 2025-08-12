part of 'cubit.dart';

class ReservationsState extends Equatable {
  final String message;
  final Status getReservationsStatus, createReservationStatus, updateReservationStatus, removeReservationStatus;
  final List<ReservationModel> reservations;

  const ReservationsState({
    this.message = '',
    this.getReservationsStatus = Status.initial,
    this.createReservationStatus = Status.initial,
    this.updateReservationStatus = Status.initial,
    this.removeReservationStatus = Status.initial,
    this.reservations = const [],
  });

  ReservationsState copyWith({
    String? message,
    Status? getReservationsStatus,
    Status? createReservationStatus,
    Status? updateReservationStatus,
    Status? removeReservationStatus,
    List<ReservationModel>? reservations,
  }) => ReservationsState(
    message: message ?? this.message,
    getReservationsStatus: getReservationsStatus ?? this.getReservationsStatus,
    createReservationStatus: createReservationStatus ?? this.createReservationStatus,
    updateReservationStatus: updateReservationStatus ?? this.updateReservationStatus,
    removeReservationStatus: removeReservationStatus ?? this.removeReservationStatus,
    reservations: reservations ?? this.reservations,
  );

  @override
  List<Object> get props => [
    message,
    getReservationsStatus,
    createReservationStatus,
    updateReservationStatus,
    removeReservationStatus,
    reservations,
  ];
}
