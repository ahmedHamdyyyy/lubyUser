import 'package:dio/dio.dart';

import '../../../../core/services/api_services.dart';
import '../../models/reversation.dart';

class ReservationsData {
  const ReservationsData(this._apiService);
  final ApiService _apiService;

  Future<List<ReservationModel>> getReservations(ReservationStatus status) async {
    final response = await _apiService.dio.get('registrations/me', queryParameters: {'status': status.name});
    return (response.data['data']['data'] as List).map((item) => ReservationModel.fromMap(item)).toList();
  }

  Future<ReservationModel> createReservation(ReservationModel reservation) async {
    final response = await _apiService.dio.post('registrations', data: reservation.toMap());
    if (response.statusCode != 200) throw DioException(requestOptions: response.requestOptions, response: response);
    return ReservationModel.fromMap(response.data);
  }

  Future<ReservationModel> updateReservation(ReservationModel reservation) async {
    final response = await _apiService.dio.put('/registrations/${reservation.id}', data: reservation.toMap());
    return ReservationModel.fromMap(response.data);
  }

  Future<void> removeReservation(String id) async {
    final response = await _apiService.dio.delete('/registrations/$id');
    if (response.statusCode != 200) throw Exception('Failed to delete reservation');
  }
}
