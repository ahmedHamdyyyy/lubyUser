import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../models/reversation.dart';
import '../cubit/cubit.dart';
import 'data.dart';

class ReservationsRepository {
  ReservationsRepository(this._data);
  final ReservationsData _data;

  Future<({List<ReservationModel> reservations, bool hasNextPage})> getReservations(
    bool fetchNext,
    ReservationsFilterType filter,
  ) async {
    try {
      return await _data.getReservations(fetchNext, filter);
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data['message'] != null) {
        final errorMessage = e.response!.data['message'];
        if (errorMessage is List) {
          throw Exception(errorMessage.join(', '));
        } else if (errorMessage is String) {
          throw Exception(errorMessage);
        }
      }
      throw Exception('An unknown error occurred');
    } catch (e, s) {
      debugPrint('ReservationsRepository.getReservations error: $e\n$s');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<ReservationModel> getReservation(String id) async {
    try {
      return await _data.getReservation(id);
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data['message'] != null) {
        final errorMessage = e.response!.data['message'];
        if (errorMessage is List) {
          throw Exception(errorMessage.join(', '));
        } else if (errorMessage is String) {
          throw Exception(errorMessage);
        }
      }
      throw Exception('An unknown error occurred');
    } catch (e, s) {
      debugPrint('ReservationsRepository.getReservation error: $e\n$s');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<ReservationModel> createReservation(ReservationModel reservation) async {
    try {
      return await _data.createReservation(reservation);
    } on DioException catch (e, s) {
      debugPrint('ReservationsRepository.createReservation dio error: $e\n$s');
      if (e.response?.data != null && e.response?.data['error'] != null) {
        final errorMessage = e.response!.data['error'];
        if (errorMessage is List) {
          throw Exception(errorMessage.join(', '));
        } else if (errorMessage is String) {
          throw Exception(errorMessage);
        }
      }
      throw Exception('An unknown error occurred');
    } catch (e, s) {
      debugPrint('ReservationsRepository.createReservation error: $e\n$s');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<ReservationModel> updateReservation(ReservationModel reservation) async {
    try {
      return await _data.updateReservation(reservation);
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data['message'] != null) {
        final errorMessage = e.response!.data['message'];
        if (errorMessage is List) {
          throw Exception(errorMessage.join(', '));
        } else if (errorMessage is String) {
          throw Exception(errorMessage);
        }
      }
      throw Exception('An unknown error occurred');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<void> removeReservation(String id) async {
    try {
      return await _data.removeReservation(id);
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data['message'] != null) {
        final errorMessage = e.response!.data['message'];
        if (errorMessage is List) {
          throw Exception(errorMessage.join(', '));
        } else if (errorMessage is String) {
          throw Exception(errorMessage);
        }
      }
      throw Exception('An unknown error occurred');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<String> payment(String reservationId) async {
    try {
      return await _data.payment(reservationId);
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data['message'] != null) {
        final errorMessage = e.response!.data['message'];
        if (errorMessage is List) {
          throw Exception(errorMessage.join(', '));
        } else if (errorMessage is String) {
          throw Exception(errorMessage);
        }
      }
      throw Exception('An unknown error occurred');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
