import 'package:dio/dio.dart';

import '../../../../core/services/api_services.dart';
import '../../models/reversation.dart';

class ReservationsData {
  ReservationsData(this._apiService);
  final ApiService _apiService;
  int _currentPage = 1;

  Future<({List<ReservationModel> reservations, bool hasNextPage})> getReservations(
    bool fetchNext,
    ReservationStatus status,
  ) async {
    _setPage(fetchNext);
    final response = await _apiService.dio.get(
      'registrations/me',
      queryParameters: {'status': status.name, 'page': _currentPage},
    );
    print(response.data);
    if (response.statusCode != 200) throw DioException(requestOptions: response.requestOptions, response: response);
    final reservations =
        ((response.data['data']?['data'] as List?) ?? []).map((item) => ReservationModel.fromMap(item)).toList();
    final hasNextPage = (response.data['data']?['pagination']?['hasNextPage'] as bool?) ?? false;
    return (reservations: reservations, hasNextPage: hasNextPage);
  }

  void _setPage(bool fetchNext) => _currentPage = fetchNext ? _currentPage + 1 : 1;

  Future<ReservationModel> createReservation(ReservationModel reservation) async {
    final response = await _apiService.dio.post('registrations', data: reservation.toMap());
    if (response.statusCode != 200) throw DioException(requestOptions: response.requestOptions, response: response);
    return ReservationModel.fromMap(response.data['data'], item: reservation.item);
  }

  Future<ReservationModel> updateReservation(ReservationModel reservation) async {
    final response = await _apiService.dio.put('/registrations/${reservation.id}', data: reservation.toMap());
    return ReservationModel.fromMap(response.data['data'], item: reservation.item);
  }

  Future<void> removeReservation(String id) async {
    final response = await _apiService.dio.delete('/registrations/$id');
    if (response.statusCode != 200) throw Exception('Failed to delete reservation');
  }
}
