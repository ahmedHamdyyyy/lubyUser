part of 'cubit.dart';

enum PaymentStatus { initial, loading, paying, success, error }

class ReservationsState extends Equatable {
  final String message;
  final Status getReservationsStatus, createReservationStatus, updateReservationStatus, removeReservationStatus;
  final List<ReservationModel> reservations;
  final ReservationModel reservation;
  final PaymentStatus paymentStatus;
  final String paymentUrl;

  const ReservationsState({
    this.message = '',
    this.getReservationsStatus = Status.initial,
    this.createReservationStatus = Status.initial,
    this.updateReservationStatus = Status.initial,
    this.removeReservationStatus = Status.initial,
    this.reservations = const [],
    this.reservation = ReservationModel.initial,
    this.paymentStatus = PaymentStatus.initial,
    this.paymentUrl = '',
  });

  ReservationsState copyWith({
    String? message,
    Status? getReservationsStatus,
    Status? createReservationStatus,
    Status? updateReservationStatus,
    Status? removeReservationStatus,
    List<ReservationModel>? reservations,
    ReservationModel? reservation,
    PaymentStatus? paymentStatus,
    String? paymentUrl,
  }) => ReservationsState(
    message: message ?? this.message,
    getReservationsStatus: getReservationsStatus ?? this.getReservationsStatus,
    createReservationStatus: createReservationStatus ?? this.createReservationStatus,
    updateReservationStatus: updateReservationStatus ?? this.updateReservationStatus,
    removeReservationStatus: removeReservationStatus ?? this.removeReservationStatus,
    reservations: reservations ?? this.reservations,
    reservation: reservation ?? this.reservation,
    paymentStatus: paymentStatus ?? this.paymentStatus,
    paymentUrl: paymentUrl ?? this.paymentUrl,
  );

  @override
  List<Object> get props => [
    message,
    getReservationsStatus,
    createReservationStatus,
    updateReservationStatus,
    removeReservationStatus,
    reservations,
    reservation,
    paymentStatus,
    paymentUrl,
  ];
}
