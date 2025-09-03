import 'package:dio/dio.dart';

import '../../models/reversation.dart';
import 'data.dart';

class ReservationsRepository {
  ReservationsRepository(this._data);
  final ReservationsData _data;

  Future<List<ReservationModel>> getReservations(ReservationStatus status) async {
    try {
      return await _data.getReservations(status);
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
      print('Error stack trace: $s');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<ReservationModel> createReservation(ReservationModel reservation) async {
    try {
      return await _data.createReservation(reservation);
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data['error'] != null) {
        final errorMessage = e.response!.data['error'];
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
}
